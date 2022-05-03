import 'package:applogin/model/seguro/seguro.dart';

class SeguroList {

  late List<Seguro> seguros;

  SeguroList.fromList(List<dynamic> data){
    seguros = [];

    for (var item in data) {
      seguros.add(Seguro.fromServiceSpring(item));
    }

  }

  SeguroList.fromDb(List<dynamic> data){
    seguros = [];

    for (var item in data) {
      seguros.add(Seguro.fromDb(item));
    }

  }
  SeguroList.fromDefault(){
    seguros = [];
  }

}