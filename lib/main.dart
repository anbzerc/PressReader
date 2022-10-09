
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pressreaderflutter/article.dart';
import 'package:pressreaderflutter/pages/Journaux.dart';
import 'package:pressreaderflutter/media/Lefigaro.dart';
import 'package:pressreaderflutter/article.dart';
import 'package:pressreaderflutter/media/opex360.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override // constructeur de l'interface
  Widget build(BuildContext context) {
    return MaterialApp( theme: ThemeData(useMaterial3: true), home: NavigationExample(), debugShowCheckedModeBanner: false,);
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  late Future<Article> futureArticle;
  late Future<List<ListeArticle>> futurelistearticle;
  bool shadowColor = false;
  double? scrolledUnderElevation;

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    futureArticle = opex360("http://www.opex360.com/2022/09/30/la-turquie-confirme-avoir-des-discussions-pour-se-procurer-des-avions-de-combat-eurofighter-typhoon/");
    futurelistearticle = listeOpex360("http://www.opex360.com");
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
        SingleChildScrollView(

          child: FutureBuilder<Article>(
            future: futureArticle,
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
                  return Column(
                    children: [
                        ArticleLayout().articlelayout(Article(title: snapshot.data!.title, auteur: snapshot.data!.auteur, description: snapshot.data!.description, urlImage: snapshot.data!.urlImage, contenu: snapshot.data!.contenu, date: snapshot.data!.date))
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
        ),
        Container(

          color: Colors.white,
          alignment: Alignment.center,
          child: Journaux().contenuJournaux(context)

        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text('Page 4'),
        ),
      ][currentPageIndex],
    );


  }

}






