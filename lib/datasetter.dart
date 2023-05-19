import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbhelper {
  static Database? database;

  Future<bool> dbsetter() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE contct (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT)');
    });
    return true;
  }
}
