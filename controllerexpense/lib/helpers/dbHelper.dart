import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Future<Database> database() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    String path = join(appDirectory.path, 'places.db');
    return await sql.openDatabase(path, version: 1,
        onCreate: (db, version) async {
      return await db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    });
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return await db.query(table);
  }
}

/*
class DbHelper {
  //instead of reapeating the code to acces db like the ones i've meantioned in the notes just create a function
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath(); //path where u store your db
    //sql.openDatabase(path)  //It'll open a Db firstly it will look for an existing one and if not found it'll create one//we simply can't just pass the dbPath because it simply passes the Folder where db is stored but we also need the databse name
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insertDb(
      String table,
      Map<String, Object>
          data) //function to insert in database, table where it is to be added to, and the data should be specified with a STring but can have any object
  async {
    //from the path package we can use join mehtod where we can have a path made up of the dbPath and a .db file i.e database
    /*when openDatabase finds the database it'll open that so that we can read and write to it------IF IT DOESN'T FIND which will happen when code excute for first time-it'll create a database
   via Oncreate function will be invoked
  */
    final db =
        await DbHelper.database(); //because the database returned is future
    //we acess the database this database method is defined by us
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  

  //To fetch data for that we need access to database
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelper.database();
    //for getting data we will be using query method
    return db.query(table);
    //it'll return a list of map as we have inserted maps duhh
  }

*/