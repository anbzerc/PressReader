import 'dart:convert';

import 'package:dart_rss/domain/rss_feed.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../models/article.dart';

class RssParser {

  Future<List<ListeArticle>> parseRssByUrl(url) async {
    var liste = List<ListeArticle>.empty(growable: true);
    // recuper le flux atom
    try {

      final client = Dio();
      final response = await client.get(url);
      final feed = RssFeed.parse(response.data);
      var index = 0;
      for(RssItem rssitem in feed.items){
        var urlimage;
        if(rssitem.media != null && index != 0)
        {
          urlimage = rssitem.media!.contents.first.url.toString(); //String().split('" width')[0].replaceAll('url="', "").replaceAll('"', "");

        }
        else {
          urlimage="erreur";
        }
        try {
          if(rssitem.link != null){


            var date = DateFormat("E, dd MMM yyyy HH:mm:ss zzz").parse(rssitem.pubDate.toString()); //"${rssitem.pubDate?.day.toString()} ${rssitem.pubDate?.month.toString()} ${rssitem.pubDate?.year.toString()} " ;
            liste.add(ListeArticle(url: rssitem.guid.toString(), titre: rssitem.title.toString(), urlimage: urlimage, date: date));
          }
        } catch(e){
          liste.add(ListeArticle(url: "erreur", titre: "erreur$e"+url, urlimage: "urlimage", date: DateTime.now()));
        }
        index=index+1;
      }
      return liste;

    }
    catch (e) {

      liste.add(ListeArticle(date: DateTime.now(), titre: "erreur  ", url: url, urlimage: ""));
      return liste;
    }





  }



  String dateFormatter(DateTime date) {
    dynamic dayData =
        '{ "1" : "Lundi", "2" : "Mardi", "3" : "Mercredi", "4" : "Jeudi", "5" : "Vendredi", "6" : "Samedi", "7" : "Dimanche" }';

    dynamic monthData =
        '{ "1" : "Janvier", "2" : "Février", "3" : "Mars", "4" : "Avril", "5" : "Mai", "6" : "Juin", "7" : "Juillet", "8" : "Août", "9" : "Septembre", "10" : "Octobre", "11" : "Novembre", "12" : "Décembre" }';

    return json.decode(dayData)['${date.weekday}'] +
        date.day.toString() +
        " " +
        json.decode(monthData)['${date.month}'] +
        " " +
        date.year.toString();
  }
}