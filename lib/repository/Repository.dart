import 'DatabaseConnnection.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  DatabaseConnection? _databaseConnnection;

  Repository(){
    _databaseConnnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database> get database async{
   if(_database != null) return _database!;
    _database = await _databaseConnnection!.setDatabase();

    return _database!;
  }

  // insert data
  insertData(table,data) async{
    var connection = await database;
    return await connection.insert(table, data);
  }

  // Fetch data
  fetchData(table) async{
    var connection = await database;
    return await connection.query(table);
  }

  // update
  updateData(table,data) async{
    var connection = await database;
    return await connection.update(table, data,where: "id = ?",whereArgs:[data["id"]]);
  }

  // delete account
  deleteAccount(table,String id) async{
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table where id = '$id'");
  }

  // drop table
  dropTable(String table) async{
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table");
  }

  // drop database
  dropDatabase() async{
    var connection = await database;
    return await connection.rawDelete("DROP DATABASE soccachat_db");
  }


}