

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class RealTimeRepository{

  final FirebaseDatabase database = FirebaseDatabase.instance;

  Stream stream () {
    DatabaseReference ref = database.ref("mode");
    return ref.onValue;
  }

  
  

  void updateThemeMode() async{

    DatabaseReference ref = database.ref("mode");

    final estadoSnapshot = await ref.child("theme").get();
    if( estadoSnapshot.exists){

      final estado = estadoSnapshot.value as String;

      if(estado == "claro"){
        await ref.update({
          "theme": "obscuro"
        });
      }else {        
        await ref.update({
          "theme": "claro"
        });
      }

    }else{
      print("--------->Error");
    }

  }

}