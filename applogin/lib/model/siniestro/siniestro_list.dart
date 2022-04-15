
import 'package:applogin/model/siniestro/siniestro.dart';

class SiniestroList {

  late List<Siniestro> siniestros;

  SiniestroList.fromList(List<dynamic> data){
    siniestros = [];

    for (var item in data) {
      siniestros.add(Siniestro.fromServiceSpring(item));
    }

  }

  SiniestroList.fromDefault(){
    siniestros = [];
  }
}