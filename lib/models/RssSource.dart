import 'dart:convert';

import 'package:flutter/services.dart';

class RssSourceModel {

  final String name;
  final String imagePath;
  final String url;
  final List<String> rubriques;
  final List<String> rss;
  //final bool HasParsingSupport;

  RssSourceModel({
    required this.name,
    required this.imagePath,
    required this.url,
    required this.rubriques,
    required this.rss,
    /* todo this.HasParsingSupport = false*/
  });

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'imagepath' : imagePath,
      'url' : url,
      'rss' : rss.join("_"),
      'rubriques' : rubriques.join("_")
      /*'hasParsingSupport' : HasParsingSupport*/
    };
  }


  factory RssSourceModel.fromMap(Map<String, dynamic> map) =>
      RssSourceModel(name: map["name"],imagePath: map['imagePath'],url: map["url"],rubriques: map["rubriques"].toString().split("_"), rss: map["rss"].toString().split("_"),/* HasParsingSupport: map["hasParsingSupport"]*/);

  factory RssSourceModel.fromJson(Map<String, dynamic> map) {
    var maprubriques = map["rss"] as Map<String, String>;
    List<String> rss = maprubriques.values.toList();
    return RssSourceModel(name: map["name"],imagePath: map['imagePath'],url: map["url"],rubriques: map["rubriques"].toString().split("_"), rss: rss,/* HasParsingSupport: map["hasParsingSupport"]*/);
  }
}
