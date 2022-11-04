import 'dart:convert';

import 'package:flutter/services.dart';

class RssSourceModel {

  final String name;
  final String imagepath;
  bool isparsingsupported;
  final String url;
  final List<String> rubriques;
  final List<String> rss;
  //final bool HasParsingSupport;

  RssSourceModel({
    required this.name,
    required this.imagepath,
    this.isparsingsupported = false,
    required this.url,
    required this.rubriques,
    required this.rss,
    /* todo this.HasParsingSupport = false*/
  });

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'imagepath' : imagepath,
      'isparsingsupported' : isparsingsupported,
      'url' : url,
      'rss' : rss.join("_"),
      'rubriques' : rubriques.join("_")
      /*'hasParsingSupport' : HasParsingSupport*/
    };
  }


  factory RssSourceModel.fromMap(Map<String, dynamic> map) =>
      RssSourceModel(name: map["name"],imagepath: map['imagepath'],isparsingsupported: map['isparsingsupported'], url: map["url"],rubriques: map["rubriques"].toString().split("_"), rss: map["rss"].toString().split("_"),/* HasParsingSupport: map["hasParsingSupport"]*/);

}
