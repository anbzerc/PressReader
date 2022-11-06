import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pressreaderflutter/models/RssSourceModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pressreaderflutter/models/article.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  static Database? _database;

  Future<Database> get databaseService async =>
    //??= fait une null check et s'execute si null
    _database ??= await initDB();



  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "database.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      // creer la table pour sauvegarder des articles
      await db.execute("CREATE TABLE Article ("
          "url TEXT PRIMARY KEY,"
          "titre TEXT,"
          "urlimage TEXT,"
          "date TEXT"
          ")");

      //créer la table pour ajouter des sources rss
      await db.execute("CREATE TABLE RssSources(name TEXT PRIMARY KEY, imagepath TEXT, isparsingsupported INTEGER, url TEXT, rubriques TEXT, rss TEXT )");
    }
    );
  }

  void InsertRssSource(RssSourceModel rssSource) async {
    final Database database  = await instance.databaseService;
    await database.insert('RssSources', rssSource.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

  }

  void UpdateRssSource(RssSourceModel rssSource) async {
    final Database database  = await instance.databaseService;
    await database.update('RssSources', rssSource.toMap(),where: "name = ?", whereArgs: [rssSource.name] );

  }

  void DeleteRssSource(RssSourceModel rssSource) async {
    final Database database  = await instance.databaseService;
    await database.delete('RssSources', where: "name = ?", whereArgs: [rssSource.name] );

  }

  Future<List<RssSourceModel>> GetAllRssSource () async {
    final Database database  = await instance.databaseService;
    final List<Map<String, dynamic>> maps = await database.query("RssSources");
    List<RssSourceModel> rssSources = List.generate(maps.length, (index) => RssSourceModel.fromMap(maps[index]));

    if(rssSources.isEmpty){
      rssSources = [RssSourceModel(name: "any",url: "", imagepath: "",isparsingsupported: false, rubriques: List<String>.empty(), rss: List<String>.empty())];
    }

    return rssSources;
  }


}