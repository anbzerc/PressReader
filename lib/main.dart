
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pressreaderflutter/models/RssSourceModel.dart';
import 'package:pressreaderflutter/models/article.dart';
import 'package:pressreaderflutter/pages/Journaux.dart';
import 'package:pressreaderflutter/media/Lefigaro.dart';
import 'package:pressreaderflutter/pages/settings.dart';
import 'package:pressreaderflutter/services/database.dart';
import 'package:pressreaderflutter/services/renderFromHTML.dart';
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
  bool shadowColor = false;
  double? scrolledUnderElevation;
  var _databaseService = DatabaseService.instance;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    futurelistearticle = AllListeFigaro();
    return Scaffold(
      appBar: AppBar(
        title: const Text("PressReader", style: TextStyle(fontFamily: "Caveat", fontSize: 25),),
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
        Container(child: Text("bjr"),),
        Container(

          color: Colors.white,
          alignment: Alignment.center,
          child: Journaux()

        ),
       FutureBuilder(
           future: renderFromHTML().render("https://www.valeursactuelles.com/monde/twitter-files-elon-musk-revele-les-dessous-de-la-censure-du-scandale-hunter-biden"),
           builder: (context, AsyncSnapshot snapshot) {
             if(snapshot.hasData){
               return snapshot.data! ;
             }
             else {
               return Text("en chargement");
             }
           },),
        SettingsPage(),
      ][currentPageIndex],
    );


  }

}






