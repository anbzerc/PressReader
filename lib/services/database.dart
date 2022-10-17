import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pressreaderflutter/models/article.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  static Database? _database;
  Future<Database?> get datatabase async {
    if (_database == null) {
      return await initDB();
    }
    return _database;
  }


  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "database.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Article ("
          "url TEXT PRIMARY KEY,"
          "titre TEXT,"
          "urlimage TEXT,"
          "date TEXT"
          ")");
      await db.execute("CREATE TABLE RssSources ("
          "name TEXT PRIMARY KEY,"
          "rss TEXT"
          ")");
    });
  }
}