
import 'dart:convert';

import 'package:applogin/model/cliente/cliente_list.dart';
import 'package:applogin/utils/app_type.dart';
import 'package:http/http.dart' as http;


class ApiManager {

  //Constructor nombrado y privado --> agregar _
  ApiManager._privateConstructor();
  static final ApiManager shared = ApiManager._privateConstructor();

  Future<dynamic> request({
    required String baseUrl,
    required String uri,
    required HttpType type,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams,
  }) async {
    
    Uri uri_;
    if(uriParams == null ){
      uri_  = Uri.http(baseUrl, uri);
    }else{
      uri_  = Uri.http(baseUrl, uri,uriParams);
    }


    http.Response? response = null; 

    switch(type){
      case HttpType.GET:
        response = await http.get(uri_);
        break;
      case HttpType.POST:
        response = await http.post(uri_,body: json.encode(bodyParams),headers: { "Content-Type": "application/json"});
        break;
      case HttpType.PUT:
        response = await http.put(uri_);
        break;
      case HttpType.DELETE:
        response = await http.delete(uri_);
        if(response.statusCode == 200){
          return response.body;
        } 
        break;

    }

    if(response.statusCode == 200){
      final body = json.decode(response.body);
      return body;
    }else{
      print(response.statusCode);
      print(response.body);

      throw ("Error ${response.statusCode}");
    }

  }

}