
import 'dart:convert';
import 'dart:core';

import 'package:pressreaderflutter/models/article.dart';
import 'package:flutter/services.dart';
import 'package:pressreaderflutter/models/RssSource.dart';
import 'package:pressreaderflutter/services/RssParser.dart';
import 'package:webfeed/webfeed.dart';
import 'package:xml/xml.dart';

class GetLastArticle{

  Future<List<RssSourceModel>> listeSources () async {
    List<RssSourceModel> ListeSources = List<RssSourceModel>.empty(growable: true);

    final String response = await rootBundle.loadString('assets/sources.xml');
    final data = XmlDocument.parse(response);
    for(var item in data.findAllElements("item")){
      var sources = item.getElement("categories")!.childElements.toList() ;
      List<String> rubriques = List<String>.generate(sources.length, (index) => sources[index].getElement("feedname")!.text);
      List<String> rss = List<String>.generate(sources.length, (index) => sources[index].getElement("feedurl")!.text);
      ListeSources.add(
          RssSourceModel(
              name: item.getElement("feedname")!.text,
              imagePath: item.getElement("imagepath")!.text,
              url: item.getElement("feedurl")!.text,
              rubriques: rubriques,
              rss: rss ));
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


















