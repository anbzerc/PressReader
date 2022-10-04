
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pressreaderflutter/media/Lefigaro.dart';

import 'media/opex360.dart';
class ListeArticle{
  final String url;
  final String titre;
  final String urlimage;
  final DateTime date;

  const ListeArticle({
    required this.url,
    required this.titre,
    required this.urlimage,
    required this.date
});

  Map<String, dynamic> toMap(){
    return {
      'url' : url,
      'titre' : titre,
      'urlimage' : urlimage,
      'date' : date,
    };
  }

  factory   ListeArticle.fromMap(Map<String, dynamic> map) => ListeArticle(
      url: map['url'], titre: map['titre'], urlimage: map['urlimage'], date: map['date']);

}
class Article {
  final String title;
  final String auteur;
  final String description;
  final String urlImage;
  final String contenu;
  final String date;

  const Article({
    required this.title,
    required this.auteur,
    required this.description,
    required this.urlImage,
    required this.contenu,
    required this.date
});

}

class ArticleLayout extends StatelessWidget {
  const ArticleLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return articlelayout(Article as Article);
  }

  @override
  Widget articlelayout(Article article){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Image.network(article.urlImage),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(article.title, style: TextStyle(fontSize: 27, fontFamily: "titre" )),
        ),
        /*Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(article.description, style: TextStyle(fontSize: 28, fontFamily: "texte")),
        ),*/
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: Text("${article.auteur}", style: TextStyle(fontSize: 25, fontFamily: "titre"),textAlign: TextAlign.start, )),
        ),
        /*Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(article.date, style: TextStyle(fontSize: 22, fontFamily: "titre"), textAlign: TextAlign.start, ),
        ),*/
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(article.contenu, style: TextStyle(fontSize: 23, fontFamily: "texte")),
        )
      ],
    );


}}

class ListeArticleLayout extends StatelessWidget {
  const ListeArticleLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    late Future<List<ListeArticle>> futurelistearticle;
    return ListViewArticleLayout(ListeArticle as ListeArticle);
  }

  @override
  Widget ListViewArticleLayout(ListeArticle article){
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.fromLTRB(19, 22, 19, 0),
                    child: ClipRRect(
                          child: Image.network(article.urlimage, filterQuality: FilterQuality.high),
                          borderRadius: BorderRadius.circular(10),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(19, 10, 19, 0),
                    child: Image.asset("assets/zone-militaire.png", width: 96.66666666666667, height: 23.333333333333332, filterQuality: FilterQuality.high,),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                    child: Text(article.titre.replaceAll(article.titre[2], ""), style: TextStyle(fontSize: 17, fontFamily: "sansserif"), textAlign: TextAlign.left, ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
                    child: Text(article.date.toString(), style: TextStyle(fontSize: 12, fontFamily: "sansserif"), textAlign: TextAlign.start, ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(19, 10, 19, 0),
                    child: Divider(
                      color: Colors.grey,

                    ),
                  )





          ],
        );


  }

  @override
  listearticlelayout(List<ListeArticle> listearticle){
    var listecard = List<Widget>.empty(growable: true);

    for(var element in listearticle){
      listecard.add(Card(
        child: Column(
          children: [
            Image.network(element.urlimage),
            Text(element.titre)
          ],
        ),
      ));
    }


    return listecard;
  }


}
