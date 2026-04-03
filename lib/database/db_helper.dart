import 'package:flutter/material.dart';
import 'package:app_week_6/models/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper{
  static final DataBaseHelper _instance = DataBaseHelper._internal();
  static Database? _database;

  factory DataBaseHelper(){
    return _instance;
  }

  DataBaseHelper._internal();

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async{
    String path = join(await getDatabasesPath(), 'app_qlsv.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute('''
          CREATE TABLE sinhviens(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT UNIQUE NOT NULL
          )
        ''');
      }
    );
  }
}