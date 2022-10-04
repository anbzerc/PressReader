import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pressreaderflutter/article.dart';

/*class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();
  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await InitDB();
    return _database;

  }

  InitDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'app_database.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE listearticle(url TEXT PRIMARY KEY, titre TEXT, urlimage TEXT, date TEXT");
      }
      version: 1
    );
  }
}*/