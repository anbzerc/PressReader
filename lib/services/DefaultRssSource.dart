
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/article.dart';

class DefaultRssSource {
  final String url;
  DefaultRssSource(this.url);

  Future<List<ListeArticle>> ArticleList() async {
    var liste = List<ListeArticle>.empty(growable: true);
    // recuper le flux atom
    try {

      final client = Dio();
      final response = await client.get(url);
      //liste.add(ListeArticle(url: "url", titre: response.data, urlimage: "urlimage", date: DateTime.now()));
      if(response.data.toString().contains('<?xml version="1.0"')==true && response.data.toString().contains('rss version="2.0"')==false){
        final feed = RssFeed.parse(response.data);

        for(RssItem rssitem in feed.items!){
          try {
            String urlimage;
            String link;
            String titre;
            DateTime date;

            link= rssitem.link ?? rssitem.link ?? "Erreur" ;
            urlimage = "https://www.lyoncapitale.fr/wp-content/themes/siteorigin-fidumedias/images/lyoncap/actularge.jpg";
            titre = rssitem.title ?? "Erreur" ;
            date=DateTime.now();
            liste.add(ListeArticle(url: link, urlimage: urlimage, titre: titre, date: date));
          } catch(e){
            return [ListeArticle(url: "url", titre: "Erreur $e $url", urlimage: "urlimage", date: DateTime.now())];
          }

        }
        return liste;

      }else{
        final feed = RssFeed.parse(response.data);

        for(RssItem rssitem in feed.items!){
          try {
            String urlimage;
            String link;
            String titre;
            DateTime date;

            link= rssitem.link ?? rssitem.guid ?? "Erreur" ;
            try{
              urlimage = rssitem.media!.contents!.first.url!;
            }catch(e) {
              urlimage = "erreur";
            }
            titre = rssitem.title ?? "Erreur" ;
            if(rssitem.pubDate!=null) { date=rssitem.pubDate as DateTime;}
            else {date=DateTime.now();}
            liste.add(ListeArticle(url: link, urlimage: urlimage, titre: titre, date: date));
          } catch(e){
            return [ListeArticle(url: "url", titre: "Erreur $e $url", urlimage: "urlimage", date: DateTime.now())];
          }

        }
        return liste;

      }
    }
    catch (e) {
      liste.add(ListeArticle(date: DateTime.now(), titre: "$url $e ", url: "", urlimage: ""));
      print(Text(e.toString()));
      return liste;
    }

  }
}

