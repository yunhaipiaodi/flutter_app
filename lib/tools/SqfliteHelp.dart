import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelp{
  String dbPath = "flutterapp.db";

  // return the path
  Future<String> initDeleteDb(String dbName) async {
    var databasePath = await getDatabasesPath();
    // print(databasePath);
    String path = join(databasePath, dbName);

    // make sure the folder exists
    if (await new Directory(dirname(path)).exists()) {
      await deleteDatabase(path);
    } else {
      try {
        await new Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }


  Future<Database> init() async{
    String path = await initDeleteDb(dbPath);
    Database db = await openDatabase(path);
    return db;
  }

  createTable(Database database,String createSql) async{
    await database.execute(createSql);
    return true;
  }

  insert(Database database,String insertSql) async{
    await database.rawInsert(insertSql);
    return true;
  }

  delete(Database database,String deleteSql) async{
    await database.rawDelete(deleteSql);
    return true;
  }

  update(Database database,String updateSql) async{
    await database.rawUpdate(updateSql);
    return true;
  }

  Future<List<Map>> query(Database database,String querySql) async{
    List<Map> list = await database.rawQuery(querySql);
    return list;
  }
}

