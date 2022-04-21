
import 'dart:convert';

import 'package:applogin/model/registro/registro_peticion.dart';
import 'package:applogin/repository/firebase/fire_store_repository.dart';
import 'package:applogin/repository/firebase/gps_repository.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class ApiManager {

  //Constructor nombrado y privado --> agregar _
  ApiManager._privateConstructor();
  static final ApiManager shared = ApiManager._privateConstructor();
  final repo = FireStoreREpository();
  final GPS = GPSRepository();

  Future<dynamic> request({
    required String baseUrl,
    required String uri,
    required HttpType type,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams,
  }) async {

    Map<String, String> headers = {
      "Accept": "application/json"
    };

    Uri uri_=  Uri.http(baseUrl, uri,uriParams);
    
    print(uri_);    

    final ubicacion = await GPS.determinePosition();

    http.Response? response = null; 

    switch(type){
      case HttpType.GET:
        response = await http.get(uri_,headers: headers);
        repo.registrarGet(
          RegistroPeticion(peticion: uri_.toString(),latitud: ubicacion.latitude, longitud: ubicacion.longitude)
        );

        break;
      case HttpType.POST:
        response = await http.post(uri_,body: json.encode(bodyParams),headers: { "Content-Type": "application/json"});
        repo.registrarPostUpdate(
          RegistroPeticion(peticion: uri_.toString(),latitud: ubicacion.latitude, longitud: ubicacion.longitude)
        );
        break;
      case HttpType.PUT:
        response = await http.put(uri_);
        repo.registrarPostUpdate(
          RegistroPeticion(peticion: uri_.toString(),latitud: ubicacion.latitude, longitud: ubicacion.longitude)
        );

        break;
      case HttpType.DELETE:
        response = await http.delete(uri_);
        repo.registrarDelete(
          RegistroPeticion(peticion: uri_.toString(),latitud: ubicacion.latitude, longitud: ubicacion.longitude)
        );

        if(response.statusCode == 200){
          return response.body;
        } else{
          Future.error('Error en peticion delete');
        }

        break;

    }

    if(response.statusCode == 200){

      final body = json.decode(response.body);
      return body;

    }else{
      
      Future.error('Error ${response.statusCode}');
      FlutterError.reportError(FlutterErrorDetails(
        exception: "Error en peticion ${uri_.path}",
        library: 'Flutter framework',
        context: ErrorSummary('Presionando un boton '),
      ));

      return "[]";               
    }

  }

}