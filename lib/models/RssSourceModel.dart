import 'dart:convert';

import 'package:flutter/services.dart';

class RssSourceModel {

  final String name;
  final String imagepath;
  final bool isparsingsupported;
  final String url;
  final List<String> rubriques;
  final List<String> rss;
  //final bool HasParsingSupport;

  RssSourceModel({
    required this.name,
    required this.imagepath,
    required this.isparsingsupported,
    required this.url,
    required this.rubriques,
    required this.rss,
    /* todo this.HasParsingSupport = false*/
  });

  Map<String, dynamic> toMap(){
    var intBool;
    if(isparsingsupported==true){
      intBool=1;
    }else{intBool=0;}
    return {
      'name' : name,
      'imagepath' : imagepath,
      'isparsingsupported' : intBool,
      'url' : url,
      'rss' : rss.join("/*Join*/"),
      'rubriques' : rubriques.join("/*Join*/")
      /*'hasParsingSupport' : HasParsingSupport*/
    };
  }

  factory RssSourceModel.empty(){
    return RssSourceModel(name: "", imagepath: "", isparsingsupported: false, url: "", rubriques: ["rubriques"], rss: ["rss"]);
  }


  factory RssSourceModel.fromMap(Map<String, dynamic> map) {

    return RssSourceModel(name: map["name"],
      imagepath: map['imagepath'],
      isparsingsupported: map['isparsingsupported'] == 0 ,
      url: map["url"],
      rubriques: map["rubriques"].toString().split("/*Join*/"),
      rss: map["rss"].toString().split(
          "/*Join*/"), /* HasParsingSupport: map["hasParsingSupport"]*/);
  }
}
