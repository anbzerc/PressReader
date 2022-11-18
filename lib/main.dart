
import 'dart:convert';

import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pressreaderflutter/models/RssSourceModel.dart';
import 'package:pressreaderflutter/models/article.dart';
import 'package:pressreaderflutter/pages/Journaux.dart';
import 'package:pressreaderflutter/media/Lefigaro.dart';
import 'package:pressreaderflutter/models/article.dart';
import 'package:pressreaderflutter/media/opex360.dart';
import 'package:pressreaderflutter/services/LastArticle.dart';
import 'package:pressreaderflutter/services/database.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override // constructeur de l'interface
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
            useMaterial3: true
        ),
        themeAnimationCurve: Curves.slowMiddle,

        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int currentPageIndex = 0;
  late Future<Article> futureArticle;
  late Future<List<ListeArticle>> futurelistearticle;
  late Future<List<RssSourceModel>> futurersssSources;
  late DatabaseService _databaseService;
  bool shadowColor = false;
  double? scrolledUnderElevation;

  @override
  void initState() {
    super.initState();
    _databaseService = DatabaseService.instance;
  }
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    //futurersssSources = GetLastArticle().listeSources();
    futurelistearticle = AllListeFigaro();
    return Scaffold(
      appBar: AppBar(
        title: Text("PressReader", style: TextStyle(fontFamily: "Caveat", fontSize: 25),),
        centerTitle: true,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
      ),
      bottomNavigationBar: NavigationBar(

          surfaceTintColor: Colors.white ,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: "Acceuil",
            ),
            NavigationDestination(
              icon: Icon(Icons.newspaper_rounded),
              label: 'Journaux',
            ),
            NavigationDestination(
              icon: Icon(Icons.book_rounded),
              label: 'Ma Collection',
            ),
            NavigationDestination(
                icon: Icon(Icons.menu_rounded),
                label: "Reglages"
            )
          ],
          animationDuration: Duration(milliseconds: 600)),
      body: <Widget>[
        FutureBuilder(
          future: futurelistearticle,
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
                                                            date: snapshot.data!.date), context)
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
                              child: ItemListeArticleLayout(snapshot.data![index]),
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
        ),
        Container(

          color: Colors.white,
          alignment: Alignment.center,
          child: Journaux()

        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(

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
          )
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            children: [
              MaterialButton(onPressed:() => DatabaseService.instance.DeleteRssSource(RssSourceModel(name: "Le Figaro",isparsingsupported: true, imagepath: "imagePath", url: "url", rubriques: ["rubriques"], rss: ["rss"])), child: Text("lE FIGARO"),),
              MaterialButton(onPressed:() => DatabaseService.instance.DeleteRssSource(RssSourceModel(name: "Opex360", imagepath: "imagePath",isparsingsupported: true, url: "url", rubriques: ["rubriques"], rss: ["rss"])), child: Text("Opex360"),)
            ],
          )
        ),
      ][currentPageIndex],
    );


  }

}






