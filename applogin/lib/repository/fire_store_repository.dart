
import 'package:applogin/model/registro/registro_peticion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreREpository {

  final FirebaseFirestore db = FirebaseFirestore.instance;


  Future<void> registrarGet(RegistroPeticion peticion) async{

    CollectionReference registros = db.collection("Get");

    await registros.add({
      'URL':peticion.peticion,
      'latitud':peticion.latitud,
      'longitud':peticion.longitud
    });


  }


  Future<void> registrarPostUpdate(RegistroPeticion peticion) async{

    CollectionReference registros = db.collection("PostUpdate");

    await registros.add({
      'URL':peticion.peticion,
      'latitud':peticion.latitud,
      'longitud':peticion.longitud
    });


  }

  
  Future<void> registrarDelete(RegistroPeticion peticion) async{

    CollectionReference registros = db.collection("Delete");

    await registros.add({
      'URL':peticion.peticion,
      'latitud':peticion.latitud,
      'longitud':peticion.longitud
    });


  }


}