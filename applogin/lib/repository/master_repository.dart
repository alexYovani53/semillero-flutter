
import 'package:applogin/repository/db_manager.dart';
import 'package:sqflite/sqflite.dart';

abstract class MasterRepository {

  Future<dynamic> save({required List<dynamic> data, required String tableName}) async {
    Database dbManager = await DbManager().db;

    // Se usa debido a que cuando se inserta en la BD, esta se bloquea 
    // por lo que se almacena todo en el batch para lucho hacer el commit
    Batch batch = dbManager.batch();

    for (var item in data) {
      batch.insert(tableName, item.toDatabase());
    }

    return batch.commit();

  }

  
  Future<void> truncate({required String tableName}) async {
    print("TRUNCANDOOOOO TABLA");
    Database dbManager = await DbManager().db;
    dbManager.execute("DELETE FROM $tableName");
  }

  Future<void> delete({required String tableName}) async {
    Database dbManager = await DbManager().db;
    dbManager.delete(tableName);
  }


  Future<int> deleteWhere({required String tableName, required String whereClause, required List<String> whereArgs}) async {

    Database dbManager = await DbManager().db;
    return await dbManager.delete(tableName,where: whereClause, whereArgs: whereArgs);

  }

  Future<void> addColumn({required String tableName, required String columnName }) async{

    Database dbManager = await DbManager().db;
    await dbManager.execute("ALTER TABLE ${tableName} ADD COLUMN ${columnName} Text");
  }
  
  Future<void> update({required String tableName, required String columnName, required String value})async {
    Database dbManager = await DbManager().db;
    dbManager.rawUpdate("UPDATE $tableName set $columnName = ?",[value]);
  }

  Future<List<Map<String, dynamic>>> selectAll({required String tableName}) async {

    Database dbManager = await DbManager().db;
    return await dbManager.query(tableName);
  }

  
  Future<List<Map<String, dynamic>>> selectAllWhere({required String tableName, required String whereClause, required List<String> whereArgs}) async {

    Database dbManager = await DbManager().db;
    return await dbManager.query(tableName,where: whereClause, whereArgs: whereArgs);

  }

}