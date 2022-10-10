

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:pressreaderflutter/article.dart';
import 'package:chaleno/chaleno.dart' ;

import 'package:web_scraper/web_scraper.dart';
import 'package:pressreaderflutter/article.dart';

const List<Widget> FirstPageSelected = <Widget>[
  Text('   1   '),
  Text('Suivante >')
];

List<Widget> pageSelected(String index) {
  return <Widget>[
  const Text(' < Précedente '),
  Text(index),
  const Text(' Suivante > ')
];
}

final List<bool> _FirstPageSelected = <bool>[true, false];
final List<bool> _PageSelected = <bool>[false, true, false];

class Opex360State extends StatefulWidget {
  const Opex360State({super.key, required this.urlpourlaliste});

  final String urlpourlaliste;

  @override
  State<Opex360State> createState() => _Opex360(urlpourlaliste: urlpourlaliste,);
}

class _Opex360 extends State<Opex360State>{
  final String urlpourlaliste;
  _Opex360({required this.urlpourlaliste});
  late Future<List<ListeArticle>> futurelistearticle;
  late Future<Article> futureArticle;


  @override
  Widget build(BuildContext context) {

    futurelistearticle = listeOpex360(urlpourlaliste);
    return Center(
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

                  return Column(
                    children: [ Expanded(

                        child: ListView.builder(

                            //shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,

                            itemBuilder: (context, index) {
                              var urlimage=snapshot.data![index].urlimage;
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context, MaterialPageRoute(builder: (context) =>
                                    FutureBuilder<Article>(
                                        future: opex360(snapshot.data![index].url),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: const [
                                                  CircularProgressIndicator(
                                                    semanticsLabel: "Chargement...",),
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
                                                        child: Column(children: [
                                                          ArticleLayout().articlelayout(Article(
                                                              title: snapshot.data!.title,
                                                              url: snapshot.data!.url,
                                                              auteur: snapshot.data!.auteur,
                                                              description: snapshot.data!.description,
                                                              urlImage: urlimage,//urlimage,
                                                              contenu: snapshot.data!.contenu,
                                                              date: snapshot.data!.date))
                                                        ],

                                                        )
                                                    )

                                                );
                                            }
                                            else {
                                              return const Text('Empty data');
                                            }
                                          } else {
                                            return Text('State: ${snapshot
                                                .connectionState}');
                                          }
                                        }
                                    ))),
                                child: ListeArticleLayout().ListViewArticleLayout(snapshot.data![index]),
                                //Text(snapshot.data![index].urlimage),
                              );
                            }
                        )
                    ),
                      /* TODO faire la pagination*/
                      /*if(urlpourlaliste=="http://www.opex360.com")...[
                      ToggleButtons(
                          borderRadius: const BorderRadius.all(Radius.circular(30)),
                          isSelected: _FirstPageSelected,
                          onPressed: (int index){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                Opex360State(urlpourlaliste: "http://www.opex360.com/page/2/",)));
                          },
                          children: FirstPageSelected)
                      ]else...[
                        ToggleButtons(
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                            isSelected: _PageSelected,
                            onPressed: (int index){
                              if(index==0){
                                if (int.parse(urlpourlaliste.split("page/")[1].replaceAll("/", ""))!=2) {
                                  var indexpage = int.parse(urlpourlaliste.split("page/")[1].replaceAll("/", ""));
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      Scaffold(body: Opex360State(urlpourlaliste: "http://www.opex360.com/page/${indexpage-1}/",))));
                                }else {
                                  var indexpage = int.parse(urlpourlaliste.split("page/")[1].replaceAll("/", ""));
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      Opex360State(urlpourlaliste: "http://www.opex360.com/",)));
                                }
                              }else if(index == 2 ){
                                var indexpage = int.parse(urlpourlaliste.split("page/")[1].replaceAll("/", ""));
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                    Opex360State(urlpourlaliste: "http://www.opex360.com/page/${indexpage+1}/",)));
                              }
                            },
                            children: pageSelected(urlpourlaliste.split("page/")[1].replaceAll("/", "")))

                      ]*/



                    ],
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
      );
  }
}
Future<Article> opex360(urlarticle) async {
//Getting the response from the targeted url
  final response = await Chaleno().load(urlarticle);

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
                  "&amp;", "&").replaceAll('<div class="swp-content-locator"></div>', "")
                  .replaceAll('<div class="swp-content-locator', "");
        }
      }
      compteur=compteur+1;
    }
    //content.forEach((elements) => {contenufinal = "$contenufinal${elements.text}".replaceAll("Partagez", " ").replaceAll("Tweetez", "").replaceAll("Enregistrer", " ").split("   ")[1].replaceAll("  ", "\n")});
    contenufinal = contenufinal.replaceAll("[", "(");
    contenufinal = contenufinal.replaceAll("]", ")").replaceAll('<div class="swp-content-locator', "");
    /* TODO */
    /*if(contenufinal.contains("<a ")){
      contenufinal = contenufinal.
  }*/

    return Article(title: titre.toString(),url: urlarticle, auteur: auteurfinal.toString(), description: description.toString(), urlImage: imageurlfinal.toString(), contenu: contenufinal.replaceAll("</div>", "").replaceAll("&nbsp;", " "), date: '') ;
  } catch (e) {
    return Article(title: 'Une erreur " $e " \n est survenue, veuillez réessayer"',url: urlarticle, auteur:"" , description: "", urlImage: "https://as2.ftcdn.net/v2/jpg/01/94/81/49/1000_F_194814992_UWnjXEu2WbIZefe9ZOAArxFRpVBG2u0M.jpg", contenu: "", date: "");
  }

}

Future<List<ListeArticle>> listeOpex360(url) async {
//Getting the response from the targeted url
  final response = await Chaleno().load(url);
/* TODO opex360 from xml*/
  try {
    //Scrape tout les articles

    //on recupere les urls de tout les articles de la page
    var urls = response?.getElementsByClassName("post-title");

    var TouteLesUrlImage = List<String>.empty(growable: true);

    if(url=="http://www.opex360.com" ){

      //on recupere l'url de l'image de l'article featured
      var urlimagesfeatured = response?.getElementsByClassName("attachment-kontrast-large size-kontrast-large wp-post-image");

      //on rajoute l'url de l'image featured
      if(urlimagesfeatured!=null){
        TouteLesUrlImage.add(urlimagesfeatured.first.src.toString());}
      else {
        TouteLesUrlImage.add("https://as2.ftcdn.net/v2/jpg/01/94/81/49/1000_F_194814992_UWnjXEu2WbIZefe9ZOAArxFRpVBG2u0M.jpg");
      }

    }
    //toute les url images a part le featured
    var UrlImagesSaufFeatured = response?.getElementsByClassName("attachment-kontrast-standard size-kontrast-standard wp-post-image");




    // on met toute les urls images
    for(var element in UrlImagesSaufFeatured!){
      TouteLesUrlImage.add(element.src.toString());
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
        listearticle.add(ListeArticle(date: DateTime.now()/*datefinale[index]*/,url: urls[index].html!.split('href="')[1].split('" rel=')[0].toString(), urlimage: TouteLesUrlImage[index].replaceAll("-320x320", "").replaceAll("-320x315", ""), titre: e.text.toString().replaceAll(e.text![1], "")), );
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
