
import 'dart:convert';
import 'dart:core';

import 'package:pressreaderflutter/models/article.dart';
import 'package:flutter/services.dart';
import 'package:pressreaderflutter/models/RssSource.dart';
import 'package:pressreaderflutter/services/RssParser.dart';

class GetLastArticle{

  Future<List<RssSources>> listeSources () async {
    final String response = await rootBundle.loadString('assets/sources.json');
    final data = await jsonDecode(response);
    var sources = data["items"]["lefigaro"];
    var ListeSources = List<RssSources>.empty(growable: true);
    for(var element in sources){
      ListeSources.add(RssSources(
          name: element["name"],
          image: element["image"],
          rubriques: element["rubriques"].toString().replaceAll("[", "").replaceAll("]", "").split("_"),
          rss: element["rss"].toString().replaceAll('"', "").replaceAll("{", "").replaceAll("}", "").replaceAll("[", "").replaceAll("]", "").split(",")
      )
      );
    }
    return ListeSources;
  }

  Future<List<ListeArticle>> lastArticle() async {
    var rssSources = await listeSources();
    var LastArticle = List<ListeArticle>.empty(growable: true);

    //for(var RssSourceElement in rssSources){
    //  var index = 0;
      for(var element in rssSources.first.rss){
        LastArticle.addAll(await RssParser().parseRssByUrl(
            element.split(": ")[1].replaceAll('"', "").replaceAll("[[{", "").replaceAll("}]]", "")));
        //index++;
      }
   // }



    LastArticle.sort((a, b){
      return b.date.compareTo(a.date);
    }
    );
    return LastArticle;
  }

}


















