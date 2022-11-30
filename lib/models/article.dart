


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'article.dart';
import 'article.dart';

class ListeArticle{
  final String url;
  final String titre;
  final String urlimage;
  final DateTime date;


  ListeArticle({
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

  factory ListeArticle.fromMap(Map<String, dynamic> map) => ListeArticle(
      url: map['url'], titre: map['titre'], urlimage: map['urlimage'], date: map['date']);

}
class Article {
  final String title;
  final String auteur;
  final String description;
  final String urlImage;
  final String contenu;
  final String date;
  final String url;
  bool isPremium;

  Article({
    required this.title,
    required this.auteur,
    required this.description,
    required this.urlImage,
    required this.contenu,
    required this.date,
    required this.url,
    this.isPremium = false,
  });

  Map<String, dynamic> toMap(){
    return {
      'title' : title,
      'auteur' : auteur,
      'description' : description,
      'urlimage' : urlImage,
      'contenu' : contenu,
      'date' : date,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) => Article(
      url: map['url'],auteur: map['auteur'], contenu: map['contenu'], description: map['description'], title: map['title'], urlImage: map['urlimage'], date: map['date']);

}

class ArticleLayout extends StatelessWidget {
  const ArticleLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return articlelayout(Article as Article, context);
  }

  @override
  Widget articlelayout(Article article, BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        if  (article.description == "")...[
          CachedNetworkImage(
            cacheManager: CacheManager(Config(
                "images",
                maxNrOfCacheObjects: 100,
                stalePeriod: const Duration(minutes: 10)
            )),
            useOldImageOnUrlChange: true,
            filterQuality: FilterQuality.high,
            imageUrl: article.urlImage,

            //progressIndicatorBuilder: (context, url, downloadProgress) =>
            //    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
            errorWidget: (context, url, error) => Image.asset("assets/indisponible"),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(article.title, style: TextStyle(fontSize: 27, fontFamily: "titre" )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("${article.auteur}", style: const TextStyle(fontSize: 19, fontFamily: "titre"),textAlign: TextAlign.start, ),
          ),

          if(article.urlImage.contains("opex360")==false)...[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(article.date, style: const TextStyle(fontSize: 22, fontFamily: "titre"), textAlign: TextAlign.start, ),
            )
          ]
          ,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Text(article.contenu, style: const TextStyle(fontSize: 23, fontFamily: "texte")),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: AppBar(),
                        body: WebView(
                          initialUrl: article.url,
                        ),
                        bottomNavigationBar: BottomAppBar(
                          child: IconButton(onPressed: () => null, icon: Icon(Icons.bookmarks_outlined, color: Colors.grey, ),alignment: Alignment.centerRight, padding: EdgeInsets.fromLTRB(5, 5, 15, 5)),
                        ),
                      );
                    })), icon: Icon(Icons.language_outlined), color: Colors.grey,),

              IconButton(onPressed: () => null, icon: Icon(Icons.bookmarks_outlined, color: Colors.grey, ),alignment: Alignment.centerRight, padding: EdgeInsets.fromLTRB(5, 5, 15, 5)),
            ],
          ),

        ] else ... [

          CachedNetworkImage(
            cacheManager: CacheManager(Config(
                "images",
                maxNrOfCacheObjects: 100,
                stalePeriod: const Duration(minutes: 10)
            )),
            filterQuality: FilterQuality.high,
            imageUrl: article.urlImage,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
            errorWidget: (context, url, error) => Image.asset("assets/indisponible"),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(article.title, style: const TextStyle(fontSize: 27, fontFamily: "titre" )),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(article.description, style: const TextStyle(fontSize: 24, fontFamily: "texte"))
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("${article.auteur}", style: const TextStyle(fontSize: 19, fontFamily: "titre"),textAlign: TextAlign.start, ),
          ),

          if(article.urlImage.contains("opex360")==false)...[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(article.date, style: const TextStyle(fontSize: 19, fontFamily: "titre"), textAlign: TextAlign.start, ),
            )
          ]
          ,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Text(article.contenu, style: const TextStyle(fontSize: 23, fontFamily: "texte")),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return Scaffold(
                        appBar: AppBar(),
                        body: WebView(
                          initialUrl: article.url,
                        ),
                        bottomNavigationBar: BottomAppBar(
                          child: IconButton(onPressed: () => null, icon: Icon(Icons.bookmarks_outlined, color: Colors.grey, ),alignment: Alignment.centerRight, padding: EdgeInsets.fromLTRB(5, 5, 15, 5)),
                        ),
                      );
                    })), icon: Icon(Icons.language_outlined), color: Colors.grey,),

              IconButton(onPressed: () => null, icon: Icon(Icons.bookmarks_outlined, color: Colors.grey, ),alignment: Alignment.centerRight, padding: EdgeInsets.fromLTRB(5, 5, 15, 5)),
            ],
          ),
        ]
      ],
    );


  }}

class ItemListeArticleLayout extends StatefulWidget {
  final ListeArticle listeArticle;
  const ItemListeArticleLayout(this.listeArticle, {Key? key}) : super(key: key);

  @override
  State<ItemListeArticleLayout> createState() => _ItemListeArticleLayoutState(listeArticle);
}

class _ItemListeArticleLayoutState extends State<ItemListeArticleLayout> {
  final ListeArticle listeArticle;
  _ItemListeArticleLayoutState(this.listeArticle);

  @override
  Widget build(BuildContext context) {
    late Future<List<ListeArticle>> futurelistearticle;
    return ListViewArticleLayout(listeArticle, context);
  }

  @override
  // pour afficher une item de typer ListeArticle
  Widget ListViewArticleLayout(ListeArticle ListeArticle, BuildContext context){
    var is_image=true;
    var _opacity = 1.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        if (ListeArticle.urlimage != "erreur")...[

          Padding(
            padding: const EdgeInsets.fromLTRB(19, 22, 19, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                fadeInCurve: Curves.linear,
                fadeOutDuration: Duration.zero,
                fadeInDuration: const Duration(milliseconds: 400),
                placeholder: (context, string) => const SizedBox(height: 200, width: 400, child: null,),
                cacheManager: CacheManager(Config(
                    "images",
                    maxNrOfCacheObjects: 100,
                    stalePeriod: const Duration(minutes: 5)
                )),
                filterQuality: FilterQuality.high,
                imageUrl: ListeArticle.urlimage,
                errorWidget: (context, url, error) {
                  is_image=false;
                  return Text(ListeArticle.urlimage.toString());
                },
              ),
            ),
          )
        ],
        if(ListeArticle.url.contains("figaro")==true)...{
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 8, 19, 3),
            child: Image.asset("assets/MediaIcons/le-figaro.png", width: 96.66666666666667, height: 23.333333333333332, filterQuality: FilterQuality.high,),
          ),
        }else if(ListeArticle.url.contains("opex360")==true)...{
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 10, 19, 0),
            child: Image.asset("assets/MediaIcons/zone-militaire.png", width: 96.66666666666667, height: 23.333333333333332, filterQuality: FilterQuality.high,),
          ),
        }else if(ListeArticle.url.contains("bvoltaire")==true)...{
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 10, 19, 0),
            child: Image.asset("assets/MediaIcons/boulevard-voltaire-logo.png", width: 96.66666666666667, height: 23.333333333333332, filterQuality: FilterQuality.high,),
          ),
        }else if(ListeArticle.url.contains("areion24")==true)...{
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 10, 19, 0),
            child: Image.asset("assets/MediaIcons/aeirion24news-logo.png", width: 96.66666666666667, height: 23.333333333333332, filterQuality: FilterQuality.high,),
          ),
        }else if(ListeArticle.url.contains("causeur")==true)...{
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 10, 19, 0),
            child: Image.asset(
              "assets/MediaIcons/causeur-logo.png", width: 96.66666666666667,
              height: 23.333333333333332,
              filterQuality: FilterQuality.high,),
          )
        },


        Padding(
          padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
          child: Text(ListeArticle.titre, style: TextStyle(fontSize: 17, fontFamily: "sansserif"), textAlign: TextAlign.left, ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(19, 0, 19, 0),
          child: Text(ListeArticle.date.toString(), style: TextStyle(fontSize: 12, fontFamily: "sansserif"), textAlign: TextAlign.start, ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
          child: Divider(
            color: Colors.grey,

          ),
        ),






      ],
    );


  }
}