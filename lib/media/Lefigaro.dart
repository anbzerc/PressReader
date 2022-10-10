
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pressreaderflutter/article.dart';
import 'package:chaleno/chaleno.dart' ;
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:pressreaderflutter/services/HtmlParser.dart';

class LeFigaro extends StatelessWidget {
  LeFigaro({super.key}) ;
  late Future<List<ListeArticle>> futurelistearticle1;
  late Future<Article> futureArticle1;

  @override
  Widget build(BuildContext context) {
    futurelistearticle1 = listeFigaro("https://www.lefigaro.fr/rss/figaro_flash-actu.xml");
    return Scaffold(
        appBar: AppBar(title: const Text("Le Figaro")),
        body: FutureBuilder(
          future: futurelistearticle1,
          builder: (context , snapshot) { try {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(semanticsLabel: "Chargement..."),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.hasError) {
                return Text('${snapshot.error} occurred');
              } else if (snapshot.hasData) {
                return Column(
                  children: [ Expanded(

                      child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,

                      itemBuilder: (context, index) {
                        var urlimage=snapshot.data![index].urlimage;
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context, MaterialPageRoute(builder: (context) =>
                              FutureBuilder<Article>(
                                  future: LeFigaroArticle(snapshot.data![index].url),
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
                      })),

                  ],
                );
              }
            }
          }
          catch (e) {
            var liste = List<ListeArticle>.empty(growable: true);
            liste.add(ListeArticle(url: "", titre: "Erreur ${e}", urlimage: "", date: DateTime.now()));
            return Card(
              child: Text("Erreur ${e}"),
            );

          }
          return Text("erreur");
          } ,
        ));
  }


}


Future<Article> LeFigaroArticle(urlarticle) async {
//Getting the response from the targeted url
  final response = await Chaleno().load(urlarticle);

  var document = response?.html;
  try {
    var parser = HtmlParser(document: document.toString());
    //Scraping the first article title
    var titre = parser.title();//.first.text!.toString();
    var description = parser.description();
    var imageurl = parser.urlimage();
    //var contenufinal = "";
    var auteurfinal = "Par ";
    var contenufinal = parser.paragraph();

    var auteurtmp  = response?.getElementsByClassName("fig-content-metas__authors");
    if (auteurtmp!.isEmpty == false){auteurtmp.forEach((element) { auteurfinal = auteurfinal + element.text.toString().replaceAll("Par", "") + ", "; });}
    else {auteurfinal = "";}
    auteurfinal = auteurfinal.replaceAll("  ", "");

    var date = response?.getElementsByClassName("fig-content-metas__pub-maj-date").first.text.toString();
    return Article(title: titre.toString(),url: urlarticle, auteur: auteurfinal.toString(), description: description.toString(), urlImage: imageurl.toString(), contenu: contenufinal, date: date.toString()) ;
  } catch (e) {
    return Article(title: 'Une erreur " $e " \n est survenue, veuillez réessayer"',url: urlarticle, auteur:"" , description: "", urlImage: "https://as2.ftcdn.net/v2/jpg/01/94/81/49/1000_F_194814992_UWnjXEu2WbIZefe9ZOAArxFRpVBG2u0M.jpg", contenu: "", date: "");
  }

}


Future<List<ListeArticle>> listeFigaro(url) async {
  var liste = List<ListeArticle>.empty(growable: true);
  // recuper le flux atom
  try {

    final client = Dio();
    final response = await client.get(url);
    final feed = RssFeed.parse(response.data);

    for(RssItem rssitem in feed.items!){
      try {
      if(rssitem.link != null){

        var urlimage = rssitem.media!.contents!.first.url.toString();  //String().split('" width')[0].replaceAll('url="', "").replaceAll('"', "");
        if(urlimage.isEmpty){urlimage="";}
        var date = rssitem.pubDate as DateTime; //"${rssitem.pubDate?.day.toString()} ${rssitem.pubDate?.month.toString()} ${rssitem.pubDate?.year.toString()} " ;
        liste.add(ListeArticle(url: rssitem.link.toString(), titre: rssitem.title.toString(), urlimage: urlimage, date: date));
      }
      } catch(e){

      }

    }
    return liste;

  }
  catch (e) {

    liste.add(ListeArticle(date: DateTime.now(), titre: "erreur", url: "", urlimage: ""));
    return liste;
  }





}

Future<bool> _requestWritePermission() async {
  await Permission.storage.request();
  return await Permission.storage.request().isGranted;
}






