import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<void> insertDb(
      String table,
      Map<String, Object>
          data) //function to insert in database, table where it is to be added to, and the data should be specified with a STring but can have any object
  async {
    final dbPath = await sql.getDatabasesPath(); //path where u store your db
    //sql.openDatabase(path)  //It'll open a Db firstly it will look for an existing one and if not found it'll create one//we simply can't just pass the dbPath because it simply passes the Folder where db is stored but we also need the databse name
    final sqlDb = await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'create table user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    },
        version:
            1); //from the path package we can use join mehtod where we can have a path made up of the dbPath and a .db file i.e database
    /*when openDatabase finds the database it'll open that so that we can read and write to it------IF IT DOESN'T FIND which will happen when code excute for first time-it'll create a database
   via Oncreate function will be invoked
  */
    await sqlDb.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
}
