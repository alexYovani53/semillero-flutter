
import 'package:sqflite/sqflite.dart';

class TableManager{

  TableManager._privateConstructor();

  static final TableManager shared = TableManager._privateConstructor(); 

  Future<void> eliminarCliente(Database db) async{
    const String query = "Drop table if exists cliente";
    await db.execute(query);
  }

  Future<void> cliente(Database db) async {
    const String table = "CREATE TABLE cliente ( "+
    "id integer not null primary key autoincrement, "+
    "dniCl integer,"
    "nombreCl     text, "+
    "apellido1    text, "+
    "apellido2    text, "+
    "claseVia     text, "+
    "numeroVia    integer, "+
    "codPostal    integer, "+
    "ciudad        text, "+
    "telefono      integer, "+
    "observaciones text, "+
    "nombreVia    text);";

    await db.execute(table);
  }

    Future<void> seguro(Database db) async {
    const String table = "CREATE TABLE seguros ( " +
      "id integer not null primary key autoincrement, " +
      "numeroPoliza           integer,"
      "ramo                     text, " +
      "fechaInicio             text, " +
      "fechaVencimiento        text, " +
      "condicionesParticulares text, " +
      "dniCl                   integer);";

    await db.execute(table);
  }


  Future<void> siniestro(Database db) async {
    const String table = "CREATE TABLE siniestros ( "+
    "id integer NOT NULL primary key autoincrement, "+
    "idSiniestro    integer, "
    "fechaSiniestro text, "+
    "causas          text, "+
    "aceptado        text, "+
    "indemnizacion   integer, "+
    "numeroPoliza   integer, "+
    "dniPerito      integer);";

    await db.execute(table);
  }


}