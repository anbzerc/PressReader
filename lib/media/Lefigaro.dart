import 'dart:convert';

import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pressreaderflutter/models/article.dart';
import 'package:chaleno/chaleno.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:pressreaderflutter/services/HtmlParser.dart';
import 'package:webview_flutter/webview_flutter.dart';

const category = <Widget>[
  Tab(
    text: "La Une",
  ),
  Tab(text: "Flash Actu"),
  Tab(text: "Politique"),
  Tab(text: "International"),
  Tab(text: "Société"),
  Tab(text: "Santé"),
];

Map<String, String> category_map = {
  "La Une": "https://www.lefigaro.fr/rss/figaro_actualites.xml",
  "Flash Actu": "https://www.lefigaro.fr/rss/figaro_flash-actu.xml",
  "Politique": "https://www.lefigaro.fr/rss/figaro_politique.xml",
  "International": "https://www.lefigaro.fr/rss/figaro_international.xml",
  "Société": "https://www.lefigaro.fr/rss/figaro_actualite-france.xml",
  "Santé": "https://www.lefigaro.fr/rss/figaro_sante.xml",
};

class LeFigaro extends StatefulWidget {
  @override
  LeFigaroWidget createState() => LeFigaroWidget();
}

class LeFigaroWidget extends State<LeFigaro> {
  late Future<List<ListeArticle>> la_une;
  late Future<List<ListeArticle>> flash_actu;
  late Future<List<ListeArticle>> Politique;
  late Future<List<ListeArticle>> International;
  late Future<List<ListeArticle>> Societe;
  late Future<List<ListeArticle>> Sante;
  late Map<String, Future<List<ListeArticle>>> list_futureListeArticle = {
    "La Une": la_une,
    "Flash Actu": flash_actu,
    "Politique": Politique,
    "International": International,
    "Société": Societe,
    "Santé": Sante,
  };

  @override
  void initState() {
    WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    flash_actu = listeFigaro("https://www.lefigaro.fr/rss/figaro_flash-actu.xml");
    la_une = listeFigaro(category_map["La Une"]);
    Politique = listeFigaro(category_map["Politique"]);
    International = listeFigaro(category_map["International"]);
    Societe = listeFigaro(category_map["Société"]);
    Sante = listeFigaro(category_map["Santé"]);

    return DefaultTabController(
            animationDuration: Duration.zero,
            length: category.length,
            child: Column(
              children: [
                Container(
                  child: TabBar(
                    labelStyle:
                    const TextStyle(fontSize: 18, fontFamily: "sansserif"),
                    indicatorWeight: 3,
                    indicator: MaterialIndicator(color: Colors.blue),
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    splashFactory: NoSplash.splashFactory,
                    enableFeedback: true,
                    labelColor: Colors.black,
                    tabs: category,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      children: [
                        for (var element in category_map.entries) ...[
                          FutureBuilder(
                            future: list_futureListeArticle[element.key] as Future<List<ListeArticle>>,
                            builder: (context, AsyncSnapshot snapshot) {
                              try {
                                /*if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CircularProgressIndicator(semanticsLabel: "Chargement..."),
                                    ],
                                  ),
                                );
                              } else*/
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return Column(
                                    children: [
                                      AnimatedShimmer(
                                        width: MediaQuery.of(context).size.width-38,
                                        delayInMilliSeconds: const Duration(milliseconds: 400),
                                        height: 200,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(19, 14, 19, 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: AnimatedShimmer(
                                            width: MediaQuery.of(context).size.width-290,
                                            delayInMilliSeconds: const Duration(milliseconds: 400),
                                            height: 17,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(19, 11, 19, 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: AnimatedShimmer(
                                            width: MediaQuery.of(context).size.width,
                                            delayInMilliSeconds: const Duration(milliseconds: 400),
                                            height: 22,
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(19, 4, 19, 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: AnimatedShimmer(
                                            width: MediaQuery.of(context).size.width,
                                            delayInMilliSeconds: const Duration(milliseconds: 400),
                                            height: 22,
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),
                                      Padding(

                                        padding: const EdgeInsets.fromLTRB(19, 4, 19, 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: AnimatedShimmer(
                                            width: MediaQuery.of(context).size.width/8*3,
                                            delayInMilliSeconds: const Duration(milliseconds: 400),
                                            height: 22,
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),



                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(19, 20, 19, 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: AnimatedShimmer(
                                            width: MediaQuery.of(context).size.width-300,
                                            delayInMilliSeconds: const Duration(milliseconds: 400),
                                            height: 15,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(19, 11, 19, 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: AnimatedShimmer(
                                            width: MediaQuery.of(context).size.width,
                                            delayInMilliSeconds: const Duration(milliseconds: 400),
                                            height: 17,
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(19, 4, 19, 0),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: AnimatedShimmer(
                                            width: MediaQuery.of(context).size.width,
                                            delayInMilliSeconds: const Duration(milliseconds: 400),
                                            height: 17,
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),
                                      Padding(

                                        padding: const EdgeInsets.fromLTRB(19, 4, 19, 10),
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: AnimatedShimmer(
                                            width: MediaQuery.of(context).size.width/4,
                                            delayInMilliSeconds: const Duration(milliseconds: 400),
                                            height: 17,
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                if (snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return Text('${snapshot.error} occurred');
                                  } else if (snapshot.hasData) {
                                    return Column(
                                      children: [
                                        Expanded(
                                            child: ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  var urlimage = snapshot.data![index].urlimage;
                                                  return GestureDetector(
                                                    onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => FutureBuilder<
                                                                Article>(
                                                                future: LeFigaroArticle(snapshot.data![index].url),
                                                                builder: (context, snapshot) {
                                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                                    return Center(
                                                                      child:
                                                                      Column(crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: const [
                                                                          CircularProgressIndicator(
                                                                            semanticsLabel:
                                                                            "Chargement...",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  } else if (snapshot.connectionState == ConnectionState.done) {
                                                                    if (snapshot.hasError) {
                                                                      return Text('${snapshot.error} occurred');
                                                                    } else if (snapshot.hasData) {
                                                                      return Scaffold(
                                                                          bottomNavigationBar:
                                                                          BottomAppBar(
                                                                            child:
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                IconButton(
                                                                                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                    return Scaffold(
                                                                                      appBar: AppBar(),
                                                                                      body: WebView(
                                                                                        initialUrl: snapshot.data!.url,
                                                                                      ),
                                                                                      bottomNavigationBar: const BottomAppBar(
                                                                                        child: IconButton(
                                                                                            onPressed: null,
                                                                                            icon: Icon(
                                                                                              Icons.bookmarks_outlined,
                                                                                              color: Colors.grey,
                                                                                            ),
                                                                                            alignment: Alignment.centerRight,
                                                                                            padding: EdgeInsets.fromLTRB(5, 5, 15, 5)),
                                                                                      ),
                                                                                    );
                                                                                  })),
                                                                                  icon: const Icon(Icons.language_outlined),
                                                                                  color: Colors.grey,
                                                                                ),
                                                                                const IconButton(
                                                                                    onPressed: null,
                                                                                    icon: Icon(
                                                                                      Icons.bookmarks_outlined,
                                                                                      color: Colors.grey,
                                                                                    ),
                                                                                    alignment: Alignment.centerRight,
                                                                                    padding: EdgeInsets.fromLTRB(5, 5, 15, 5)),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          appBar:
                                                                          AppBar(),
                                                                          body: SingleChildScrollView(
                                                                              scrollDirection: Axis.vertical,
                                                                              child: Column(
                                                                                children: [
                                                                                  ArticleLayout().articlelayout(
                                                                                      Article(
                                                                                          title: snapshot.data!.title,
                                                                                          url: snapshot.data!.url,
                                                                                          auteur: snapshot.data!.auteur,
                                                                                          description: snapshot.data!.description,
                                                                                          urlImage: urlimage,
                                                                                          //urlimage,
                                                                                          contenu: snapshot.data!.contenu,
                                                                                          date: snapshot.data!.date),
                                                                                      context)
                                                                                ],
                                                                              )));
                                                                    } else {
                                                                      return const Text(
                                                                          'Empty data');
                                                                    }
                                                                  } else {
                                                                    return Text(
                                                                        'State: ${snapshot.connectionState}');
                                                                  }
                                                                }))),
                                                    child: ItemListeArticleLayout(snapshot.data![index]),
                                                    //Text(snapshot.data![index].urlimage),
                                                  );
                                                })),
                                      ],
                                    );
                                  }
                                }
                              } catch (e) {
                                var liste =
                                List<ListeArticle>.empty(growable: true);
                                liste.add(ListeArticle(
                                    url: "",
                                    titre: "Erreur ${e}",
                                    urlimage: "",
                                    date: DateTime.now()));
                                return Card(
                                  child: Text("Erreur ${e}"),
                                );
                              }
                              return Text("erreur");
                            },
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }
}

Future<Article> LeFigaroArticle(urlarticle) async {
//Getting the response from the targeted url
  final response = await Chaleno().load(urlarticle);

  var document = response?.html;

  try {
    var parser = HtmlParser(document: document.toString());
    //Scraping the article title
    var titre = parser.title();
    var description = parser.description();
    var imageurl = parser.urlimage();

    var contenu = response?.getElementsByClassName("fig-paragraph").toList();
    var contenuAParser = "";
    for (var element in contenu!) {
      contenuAParser = contenuAParser + element.html.toString();
    }
    var contenufinal =
    parser.text(contenuAParser, textClass: "fig-paragraph");

    var auteurfinal = "Par ";
    var auteurtmp =
    response?.getElementsByClassName("fig-content-metas__authors");
    if (auteurtmp!.isEmpty == false) {
      for (var element in auteurtmp) {
        auteurfinal =
            auteurfinal + element.text.toString().replaceAll("Par", "") + ", ";
      }
    } else {
      auteurfinal = "";
    }
    auteurfinal = auteurfinal.replaceAll("  ", "");

    var dateTemp = DateTime.parse(parser.date());
    var date = dateFormatter(dateTemp);
    return Article(
        title: titre.toString(),
        url: urlarticle,
        auteur: auteurfinal.toString(),
        description: description.toString(),
        urlImage: imageurl.toString(),
        contenu: contenufinal,
        date: date.toString());
  } catch (e) {
    return Article(
        title: 'Une erreur " $e " \n est survenue, veuillez réessayer"',
        url: urlarticle,
        auteur: "",
        description: "",
        urlImage: "https://as2.ftcdn.net/v2/jpg/01/94/81/49/1000_F_194814992_UWnjXEu2WbIZefe9ZOAArxFRpVBG2u0M.jpg",
        contenu: "",
        date: "");
  }
}

Future<List<ListeArticle>> listeFigaro(url) async {
  var liste = List<ListeArticle>.empty(growable: true);
  // recuper le flux atom
  try {
    final client = Dio();
    client.options.connectTimeout = 10000;
    final response = await client.get(url);
    final feed = RssFeed.parse(response.data);
    for (RssItem rssitem in feed.items!) {
      try {
        if (rssitem.link != null) {
          var urlimage = rssitem.media!.contents!.first.url.toString(); //String().split('" width')[0].replaceAll('url="', "").replaceAll('"', "");
          if (urlimage.isEmpty) {
            urlimage = "";
          }
          var date = rssitem.pubDate as DateTime; //"${rssitem.pubDate?.day.toString()} ${rssitem.pubDate?.month.toString()} ${rssitem.pubDate?.year.toString()} " ;
          liste.add(ListeArticle(
              url: rssitem.link.toString(),
              titre: rssitem.title.toString(),
              urlimage: urlimage,
              date: date));
        }
      } catch (e) {}
    }
    return liste;
  } catch (e) {
    liste.add(ListeArticle(
        date: DateTime.now(), titre: "erreur", url: "", urlimage: ""));
    return liste;
  }
}

Future<List<ListeArticle>> AllListeFigaro() async {
  var liste = List<ListeArticle>.empty(growable: true);
  //on importe le json avec les thematique et leurs urls
  final String response = await rootBundle.loadString('assets/sources.json');
  final data = await jsonDecode(response)["items"]["lefigaro"];
  final category = data["rubriques"].toString().split("_");
  final categoryUrlTemp = data["rss"]
      .toString()
      .replaceAll("{", "")
      .replaceAll("}", "")
      .replaceAll("[", "")
      .replaceAll("]", "")
      .split(",");
  final categoryLenght = category.length;
  var url = List<String>.empty(growable: true);
  var indexTmp = 0;
  while (indexTmp < categoryLenght) {
    url.add(
        categoryUrlTemp[indexTmp].split(': ')[1].replaceAll(RegExp(r""), ""));
    indexTmp++;
  }
  // recuperer les flux rss

  var listeArticle = List<ListeArticle>.empty(growable: true);
  indexTmp = 0;
  while (indexTmp < categoryLenght) {
    listeArticle.addAll(await listeFigaro(url[indexTmp]));
    indexTmp++;
  }
  listeArticle.sort((a, b) {
    return b.date.compareTo(a.date);
  });
  return listeArticle;
}

Future<bool> _requestWritePermission() async {
  await Permission.storage.request();
  return await Permission.storage.request().isGranted;
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
