import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelp{
  static String dbPath = "flutterapp.db";
  static Database db;

  // return the path
  static Future<String> initDeleteDb(String dbName) async {
    var databasePath = await getDatabasesPath();
    // print(databasePath);
    String path = join(databasePath, dbName);
    return path;
  }

  static Future<bool> init() async{
    String path = await initDeleteDb(dbPath);
    db = await openDatabase(path);
    return true;
  }

  static createTable(String createSql) async{
    await db.execute(createSql);
  }

  static insert(String insertSql) async{
    await db.rawInsert(insertSql);
  }

  static delete(String deleteSql) async{
    await db.rawDelete(deleteSql);
  }

  static update(String updateSql) async{
    await db.rawUpdate(updateSql);
  }

  static Future<List<Map>> query(String querySql) async{
    List<Map> list = await db.rawQuery(querySql);
    return list;
  }
}

