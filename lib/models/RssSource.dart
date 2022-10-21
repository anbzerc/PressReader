import 'dart:convert';

import 'package:flutter/services.dart';

class RssSources {

  final String name;
  final String image;
  final List<String> rubriques;
  final List<String> rss;
  //final bool HasParsingSupport;
  
  RssSources({
    required this.name,
    required this.image,
    required this.rubriques,
    required this.rss,
    /* todo this.HasParsingSupport = false*/
  });

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'icon' : image,
      'rss' : rss,
      'rubriques' : rubriques.join("_")
      /*'hasParsingSupport' : HasParsingSupport*/
    };
  }

  factory RssSources.fromMap(Map<String, dynamic> map) =>
      RssSources(name: map["name"],image: map['image'],rubriques: map["rubriques"].toString().split("_"), rss: map["rss"],/* HasParsingSupport: map["hasParsingSupport"]*/);


}