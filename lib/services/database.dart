import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pressreaderflutter/article.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await initDB();


  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Client ("
          "url TEXT PRIMARY KEY,"
          "titre TEXT,"
          "urlimage TEXT,"
          "date TEXT"
          ")");
      await db.execute("CREATE TABLE XML ("
          "source TEXT PRIMARY KEY,"
          "titre TEXT"
          ")");
    });
  }
}