
class Cliente{
  late int dniCl;
  late String nombreCl;
  late String apellido1;
  late String apellido2;
  late String claseVia;
  late int numeroVia;
  late int codPostal;
  late String ciudad;
  late int telefono;
  late String observaciones;
  late String nombreVia;
  String? clienteNewColumn;

  Cliente.fromServiceSpring(Map<String,dynamic> data ){
    dniCl =  data['dniCl'];
    nombreCl =  data['nombreCl'];
    apellido1 =  data['apellido1'];
    apellido2 =  data['apellido2'];
    claseVia =  data['claseVia'];
    numeroVia =  data['numeroVia'];
    codPostal =  data['codPostal'];
    ciudad =  data['ciudad'];
    telefono =  data['telefono'];
    observaciones =  data['observaciones'];
    nombreVia =  data['nombreVia'];
  }

  Cliente.fromDb(Map<String, dynamic> data){

    dniCl =  data['dniCl'];
    nombreCl =  data['nombreCl'];
    apellido1 =  data['apellido1'];
    apellido2 =  data['apellido2'];
    claseVia =  data['claseVia'];
    numeroVia =  data['numeroVia'];
    codPostal =  data['codPostal'];
    ciudad =  data['ciudad'];
    telefono =  data['telefono'];
    observaciones =  data['observaciones'];
    nombreVia =  data['nombreVia'];
    if (data['clienteNewColumn'] != null){
      clienteNewColumn = data['clienteNewColumn'];
      print("CLIENTE SI TIENE NUEVA COLUMNA");
    }else{
      print("CLIENTE NO TIENE NUEVA COLUMNA");
    }
  }

  Map<String, dynamic> toDatabase()=>{
    'nombreCl':nombreCl,
    'apellido1':apellido1,
    'apellido2':apellido2,
    'claseVia':claseVia,
    'numeroVia':numeroVia,
    'codPostal':codPostal,
    'ciudad':ciudad,
    'telefono':telefono,
    'observaciones':observaciones,
    'nombreVia':nombreVia
  };
}