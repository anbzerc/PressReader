

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:pressreaderflutter/article.dart';
import 'package:chaleno/chaleno.dart' ;
import 'package:web_scraper/web_scraper.dart';
import 'package:pressreaderflutter/article.dart';
class Opex360 extends StatelessWidget{
  Opex360({super.key});
  late Future<List<ListeArticle>> futurelistearticle;
  late Future<Article> futureArticle;

  @override
  Widget build(BuildContext context) {
    futurelistearticle = listeOpex360();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opex 360'),
      ),
      body: Center(
        child: FutureBuilder<List<ListeArticle>>(
            future: futurelistearticle,
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(semanticsLabel: "Chargement..."),
                    ],
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('${snapshot.error} occurred');
                } else if (snapshot.hasData) {

                  return ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                              Column(
                                children: [
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                          FutureBuilder<Article>(
                                              future: opex360(snapshot.data![0].url),
                                              builder: (context, snapshot){
                                                if (snapshot.connectionState == ConnectionState.waiting){
                                                  return Center(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                      ],
                                                    ),
                                                  );
                                                } else if (snapshot.connectionState == ConnectionState.done) {
                                                  if (snapshot.hasError) {
                                                    return Text('${snapshot.error} occurred');
                                                  } else if (snapshot.hasData) {
                                                    return
                                                      Scaffold(
                                                          appBar: AppBar(),
                                                        body: SingleChildScrollView(

                                                        scrollDirection: Axis.vertical,
                                                        child: Column(
                                                          children: [

                                                            ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                      ],

                                                        )
                                                        )

                                                      );
                                                  }
                                                  else {
                                                    return const Text('Empty data');
                                                  }
                                                } else {
                                                  return Text('State: ${snapshot.connectionState}');
                                                }
                                              }
                                          ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![0])
                                  ),


                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                      FutureBuilder<Article>(
                                          future: opex360(snapshot.data![1].url),
                                          builder: (context, snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Text('${snapshot.error} occurred');
                                              } else if (snapshot.hasData) {
                                                return
                                                  Scaffold(
                                                      appBar: AppBar(),
                                                      body: SingleChildScrollView(

                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [

                                                              ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                            ],

                                                          )
                                                      )

                                                  );
                                              }
                                              else {
                                                return const Text('Empty data');
                                              }
                                            } else {
                                              return Text('State: ${snapshot.connectionState}');
                                            }
                                          }
                                      ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![1])
                                  ),


                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                      FutureBuilder<Article>(
                                          future: opex360(snapshot.data![2].url),
                                          builder: (context, snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Text('${snapshot.error} occurred');
                                              } else if (snapshot.hasData) {
                                                return
                                                  Scaffold(
                                                      appBar: AppBar(),
                                                      body: SingleChildScrollView(

                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [

                                                              ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                            ],

                                                          )
                                                      )

                                                  );
                                              }
                                              else {
                                                return const Text('Empty data');
                                              }
                                            } else {
                                              return Text('State: ${snapshot.connectionState}');
                                            }
                                          }
                                      ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![2])
                                  ),


                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                      FutureBuilder<Article>(
                                          future: opex360(snapshot.data![3].url),
                                          builder: (context, snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Text('${snapshot.error} occurred');
                                              } else if (snapshot.hasData) {
                                                return
                                                  Scaffold(
                                                      appBar: AppBar(),
                                                      body: SingleChildScrollView(

                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [

                                                              ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                            ],

                                                          )
                                                      )

                                                  );
                                              }
                                              else {
                                                return const Text('Empty data');
                                              }
                                            } else {
                                              return Text('State: ${snapshot.connectionState}');
                                            }
                                          }
                                      ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![3])
                                  )
                                  ,
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                      FutureBuilder<Article>(
                                          future: opex360(snapshot.data![4].url),
                                          builder: (context, snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Text('${snapshot.error} occurred');
                                              } else if (snapshot.hasData) {
                                                return
                                                  Scaffold(
                                                      appBar: AppBar(),
                                                      body: SingleChildScrollView(

                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [

                                                              ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                            ],

                                                          )
                                                      )

                                                  );
                                              }
                                              else {
                                                return const Text('Empty data');
                                              }
                                            } else {
                                              return Text('State: ${snapshot.connectionState}');
                                            }
                                          }
                                      ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![4])
                                  ),
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                      FutureBuilder<Article>(
                                          future: opex360(snapshot.data![5].url),
                                          builder: (context, snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Text('${snapshot.error} occurred');
                                              } else if (snapshot.hasData) {
                                                return
                                                  Scaffold(
                                                    appBar: AppBar(),
                                                      body: SingleChildScrollView(

                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [

                                                              ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                            ],

                                                          )
                                                      )

                                                  );
                                              }
                                              else {
                                                return const Text('Empty data');
                                              }
                                            } else {
                                              return Text('State: ${snapshot.connectionState}');
                                            }
                                          }
                                      ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![5])
                                  ),
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                      FutureBuilder<Article>(
                                          future: opex360(snapshot.data![6].url),
                                          builder: (context, snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Text('${snapshot.error} occurred');
                                              } else if (snapshot.hasData) {
                                                return
                                                  Scaffold(
                                                    appBar: AppBar(),
                                                      body: SingleChildScrollView(

                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [

                                                              ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                            ],

                                                          )
                                                      )

                                                  );
                                              }
                                              else {
                                                return const Text('Empty data');
                                              }
                                            } else {
                                              return Text('State: ${snapshot.connectionState}');
                                            }
                                          }
                                      ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![6])
                                  ),
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                      FutureBuilder<Article>(
                                          future: opex360(snapshot.data![7].url),
                                          builder: (context, snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Text('${snapshot.error} occurred');
                                              } else if (snapshot.hasData) {
                                                return
                                                  Scaffold(
                                                    appBar: AppBar(),
                                                      body: SingleChildScrollView(

                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [

                                                              ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                            ],

                                                          )
                                                      )

                                                  );
                                              }
                                              else {
                                                return const Text('Empty data');
                                              }
                                            } else {
                                              return Text('State: ${snapshot.connectionState}');
                                            }
                                          }
                                      ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![7])
                                  ),
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                      FutureBuilder<Article>(
                                          future: opex360(snapshot.data![8].url),
                                          builder: (context, snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Text('${snapshot.error} occurred');
                                              } else if (snapshot.hasData) {
                                                return
                                                  Scaffold(
                                                    appBar: AppBar(),
                                                      body: SingleChildScrollView(

                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [

                                                              ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                            ],

                                                          )
                                                      )

                                                  );
                                              }
                                              else {
                                                return const Text('Empty data');
                                              }
                                            } else {
                                              return Text('State: ${snapshot.connectionState}');
                                            }
                                          }
                                      ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![8])
                                  ),
                                  GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                      FutureBuilder<Article>(
                                          future: opex360(snapshot.data![9].url),
                                          builder: (context, snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Text('${snapshot.error} occurred');
                                              } else if (snapshot.hasData) {
                                                return
                                                  Scaffold(
                                                    appBar: AppBar(),
                                                      body: SingleChildScrollView(

                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [

                                                              ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                            ],

                                                          )
                                                      )

                                                  );
                                              }
                                              else {
                                                return const Text('Empty data');
                                              }
                                            } else {
                                              return Text('State: ${snapshot.connectionState}');
                                            }
                                          }
                                      ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![9])
                                  ),

                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                          context, MaterialPageRoute(builder:
                                          (context)=>  //ArticleLayout().articlelayout(opex360(snapshot.data![0].url) as Article))),
                                      FutureBuilder<Article>(
                                          future: opex360(snapshot.data![10].url),
                                          builder: (context, snapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return Center(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircularProgressIndicator(semanticsLabel: "Chargement...",),
                                                  ],
                                                ),
                                              );
                                            } else if (snapshot.connectionState == ConnectionState.done) {
                                              if (snapshot.hasError) {
                                                return Text('${snapshot.error} occurred');
                                              } else if (snapshot.hasData) {
                                                return
                                                  Scaffold(
                                                      body: SingleChildScrollView(

                                                          scrollDirection: Axis.vertical,
                                                          child: Column(
                                                            children: [

                                                              ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
                                                            ],

                                                          )
                                                      )

                                                  );
                                              }
                                              else {
                                                return const Text('Empty data');
                                              }
                                            } else {
                                              return Text('State: ${snapshot.connectionState}');
                                            }
                                          }
                                      ))),
                                      child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![10])
                                  ),


                                ],
                              ),

                        ]
                    );


                }
                else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }
        ),
      ),
    );
  }
}
Future<Article> opex360(url) async {
//Getting the response from the targeted url
  final response = await Chaleno().load(url);

  var document = response?.html;
  try {
    //Scraping the first article title
    var titre = response?.getElementsByClassName("post-title").first.text!.trim();

    //on cree le String qui vas contenir les auteurs
    var auteurfinal = "";
    var auteurtmp  = response?.getElementsByClassName("post-byline");
    //on fait une boucle pour le ca ou il y a plusieurs auteurs
    if (auteurtmp!.isEmpty == false){auteurtmp.forEach((element) { auteurfinal = auteurfinal + element.text.toString().replaceAll("par", "Par "); });}
      else {auteurfinal = "";}

    // il n'y a pas de description pour les articles d'Opex360  mais l'Objet Article a un attribut description, donc on lui en renvoie une nulle
    var description = "";
      /*TODO recuperer les tags de l'article*/
      //la date est recupérée en meme temps que l'auteur
    var date = "";
    var imageurlfinal = response!.getElementsByTagName("img")!.elementAt(1).src.toString();

    var contenufinal = """""";
    var content = response.getElementsByClassName("entry-inner").first.html;
    var ListeContenuFinal = content.toString().split("<p>");
    var compteur=0;

    for(var element in ListeContenuFinal){
      if(compteur>=2 ){
        if(element.contains("blockquote") || element.contains("platform.twitter")){
          //todo
        }
        else if(element.contains("<a")){
          if(element.startsWith("<a")){
            contenufinal = contenufinal + element.split('">')[1].replaceAll('</a>', "").replaceAll("</p>", "\n").replaceAll(
                "&nbsp;", " ").replaceAll("&shy;", "").replaceAll(
                "&amp;", "&").replaceAll('<div class="swp-content-locator"></div>', "");
          }
          else{
            contenufinal = contenufinal + element.split("<a ")[0] + element.split("<a ")[1].split('">')[1].replaceAll("</a>", "").replaceAll("</p>", "\n").replaceAll(
                "&nbsp;", " ").replaceAll("&shy;", "").replaceAll(
                "&amp;", "&").replaceAll(
                '<div class="swp-content-locator"></div>', "");
        }
        }
        else {
          contenufinal = contenufinal +
              element.toString().replaceAll("</p>", "\n").replaceAll(
                  "&nbsp;", " ").replaceAll("&shy;", "").replaceAll(
                  "&amp;", "&").replaceAll(
                  '<div class="swp-content-locator"></div>', "");
        }
      }
      compteur=compteur+1;
    }
    //content.forEach((elements) => {contenufinal = "$contenufinal${elements.text}".replaceAll("Partagez", " ").replaceAll("Tweetez", "").replaceAll("Enregistrer", " ").split("   ")[1].replaceAll("  ", "\n")});
    contenufinal = contenufinal.replaceAll("[", "(");
    contenufinal = contenufinal.replaceAll("]", ")");
    /* TODO */
    /*if(contenufinal.contains("<a ")){
      contenufinal = contenufinal.
  }*/

    return Article(title: titre.toString(), auteur: auteurfinal.toString(), description: description.toString(), urlImage: imageurlfinal.toString(), contenu: contenufinal.replaceAll("</div>", "").replaceAll("&nbsp;", " "), date: '') ;
  } catch (e) {
    return Article(title: 'Une erreur " $e " \n est survenue, veuillez réessayer"', auteur:"" , description: "", urlImage: "https://as2.ftcdn.net/v2/jpg/01/94/81/49/1000_F_194814992_UWnjXEu2WbIZefe9ZOAArxFRpVBG2u0M.jpg", contenu: "", date: "");
  }

}

Future<List<ListeArticle>> listeOpex360() async {
//Getting the response from the targeted url
  final response = await Chaleno().load("http://www.opex360.com/");
/* TODO opex360 from xml*/
  try {
    //Scrape tout les articles
    
    //on recupere les urls de tout les articles de la page
    var urls = response?.getElementsByClassName("post-title");

    //on recupere l'url de l'image de l'article featured
    var urlimagesfeatured = response?.getElementsByClassName("attachment-kontrast-large size-kontrast-large wp-post-image");

    //toute les url images a part le featured
    var UrlImagesSaufFeatured = response?.getElementsByClassName("attachment-kontrast-standard size-kontrast-standard wp-post-image");


    var TouteLesUrlImage = List<Result>.empty(growable: true);
    //on rajoute l'url de l'image featured
    TouteLesUrlImage.add(urlimagesfeatured!.first);
    // on met toute les urls images
    for(var element in UrlImagesSaufFeatured!){
      TouteLesUrlImage.add(element);
    }


    //on recupere les dates de publication
    var date = response?.getElementsByClassName("post-date");
    // on met tout dans une liste de String
    var datefinale = List<String>.empty(growable: true);
    for(var element in date!){
      datefinale.add(element.text.toString());
    }


    //on crée une liste d'objet ListeArticle qu'on va renvoyer
    var listearticle = List<ListeArticle>.empty(growable: true);
    var index = 0;


    //on ajoute tout les objet article dans la liste "listeraticle"
    if(TouteLesUrlImage.length == urls!.length){
      for(var e in urls)
      {
        listearticle.add(ListeArticle(date: DateTime.now()/*datefinale[index]*/,url: urls[index].html!.split('href="')[1].split('" rel=')[0].toString(), urlimage: TouteLesUrlImage[index].src.toString().replaceAll("-320x320", ""), titre: e.text.toString()), );
        index =index+1;
      }
    }


    else{
      listearticle.add(ListeArticle(url: "erreur", titre: "${TouteLesUrlImage.length} ${urls.length}", urlimage: "urlimage", date: DateTime.now()));
    }



    return listearticle;
  } catch (e) {
    List<ListeArticle> listerreur= [ListeArticle(url: "erreur", titre: "${e}", urlimage: "urlimage", date: DateTime.now())];
    return listerreur;
  }



}

int nombrearticle(List<Result> resultats){
return resultats.length;
}
