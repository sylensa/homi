import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DatabaseConnection{
  setDatabase() async{
    print("create");
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'homitv');
    var database = await openDatabase(path, version: 3, onCreate: _onCreatingDatabase,onUpgrade: _onUpdateDatabase );
    return database;

  }

  _onCreatingDatabase(Database database, int version) async{
    print("create1");
    await database.execute("CREATE TABLE user_account(a_id INTEGER PRIMARY KEY, id TEXT,response TEXT)");
    await database.execute("CREATE TABLE user_screen(a_id INTEGER PRIMARY KEY, id TEXT,response TEXT)");

  }

  _onUpdateDatabase(Database database, int oldVersion,int newVersion) async{
    print("create2");
    if(oldVersion < newVersion){
      try{
        await database.execute("DROP TABLE user_account");
        await database.execute("CREATE TABLE user_account(a_id INTEGER PRIMARY KEY, id TEXT,response TEXT)");
      }catch(e){
        await database.execute("CREATE TABLE user_account(a_id INTEGER PRIMARY KEY, id TEXT,response TEXT)");
      }
      try{
        await database.execute("DROP TABLE user_screen");
        await database.execute("CREATE TABLE user_screen(a_id INTEGER PRIMARY KEY, id TEXT,response TEXT)");
      }catch(e){
        await database.execute("CREATE TABLE user_screen(a_id INTEGER PRIMARY KEY, id TEXT,response TEXT)");
      }
    }

  }







}