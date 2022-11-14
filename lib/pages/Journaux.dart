import 'package:flutter/material.dart';
import 'package:pressreaderflutter/layout/ListArticleLayout.dart';
import 'package:pressreaderflutter/media/Lefigaro.dart';
import 'package:pressreaderflutter/media/opex360.dart';
import 'package:pressreaderflutter/models/article.dart';
import 'package:pressreaderflutter/pages/screens/AddSourcesScreen.dart';
import 'package:pressreaderflutter/services/GetListeArticle.dart';
import 'package:pressreaderflutter/services/database.dart';

import '../models/RssSourceModel.dart';



class Journaux extends StatefulWidget {
  @override
  State<Journaux> createState() => _JournauxState();
}

class _JournauxState extends State<Journaux> {
  @override
  Widget build(BuildContext context) {
    return contenuJournaux(context);
  }

  @override
  Widget contenuJournaux(BuildContext context){

    return Scaffold(
      body: Column(
        children: [
          //thematiques
          FutureBuilder(
            future: DatabaseService.instance.GetAllRssSource(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                if (snapshot.data!.first.name != "any") {
                  List<RssSourceModel> rssSource = snapshot.data!;
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: IconButton(onPressed: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => AddSourceScreen(),
                                reverseTransitionDuration: Duration.zero,
                                transitionDuration: Duration(milliseconds: 300),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0.0, 1.0),
                                      end: Offset.zero,
                                    ).chain(CurveTween(curve: Curves.linear)).animate(animation),
                                    child: FadeTransition(opacity: animation, child: child),
                                  );
                                },));
                          },
                          icon: Icon(Icons.add_rounded),
                          alignment: Alignment.topLeft),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: rssSource.length,
                            itemBuilder: (context, index) {

                              return GestureDetector(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=> GetListeArticle().listeArticle(rssSource[index], context)
                                  )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Image.asset(rssSource[index].imagepath, width: 90),
                                        ],),
                                    ),
                                  )
                              );
                            },),
                        ),
                      ],
                    ),
                  );
                }
                else {
                  return Row(
                    children: [
                      TextButton(onPressed: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => AddSourceScreen(),
                          reverseTransitionDuration: Duration.zero,
                          transitionDuration: Duration(milliseconds: 300),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.0, 1.0),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.linear)).animate(animation),
                              child: FadeTransition(opacity: animation, child: child),
                            );
                          },));
                      },
                          child: Text("Ajouter des sources")),

                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: Image.asset("assets/newspaperIcons.jpg"),
                        ),
                      )
                    ],
                  );
                }
              }else if(snapshot.connectionState == ConnectionState.waiting) {

                return const Center(child: CircularProgressIndicator());
              }else if(snapshot.hasError){
                return Center(child: Text(snapshot.error.toString()),);
              }
              else {
                return Center(child: Text("erreur"),);
              }
            },
          ),
          //Media
          /*const Divider(color: Colors.grey,),
          SizedBox(
              width: 330,
              height: 190,
              child:GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> Scaffold(
                    appBar: AppBar(
                      title: const Text('Opex 360'),
                    ),
                    body: Opex360State(urlpourlaliste: "http://www.opex360.com",)))),
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    margin: EdgeInsets.all(10.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset("assets/globe.jpg"),),
                        Text("Opex360", style: TextStyle(fontSize: 25, fontFamily: "titre", color: Colors.blue),),

                      ],
                    )
                ),
              )
          ),
          SizedBox(
              width: 330,
              height: 190,
              child:GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> LeFigaro())),
                child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    margin: EdgeInsets.all(10.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset("assets/globe.jpg"),),
                        Text("Le figaro", style: TextStyle(fontSize: 25, fontFamily: "titre", color: Colors.blue),),

                      ],
                    )
                ),
              )
          )*/


        ],
      ),
    );

  }
}
