import 'package:flutter/material.dart';
import 'package:pressreaderflutter/layout/ListArticleLayout.dart';
import 'package:pressreaderflutter/media/Lefigaro.dart';
import 'package:pressreaderflutter/media/opex360.dart';
import 'package:pressreaderflutter/models/article.dart';
import 'package:pressreaderflutter/pages/screens/AddSourcesScreen.dart';
import 'package:pressreaderflutter/services/GetListeArticle.dart';
import 'package:pressreaderflutter/services/database.dart';

import '../models/RssSourceModel.dart';

class Journaux extends StatelessWidget {
  const Journaux({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: rssSource.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> GetListeArticle().listeArticle(rssSource[index])
                            )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                child: Column(
                                  children: [
                                    Image.asset(
                                        rssSource[index].imagepath, width: 90),
                                    Text(rssSource[index].isparsingsupported.toString())
                                  ],),
                              ),
                            )
                        );
                      },),
                  );
                }
                else {
                  return Row(
                    children: [
                      TextButton(onPressed: () => showGeneralDialog(
                          transitionBuilder: (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.0, 1.0),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.linear)).animate(animation),
                              child: FadeTransition(opacity: animation, child: child),
                            );
                            return child;
                          },

                          transitionDuration: const Duration(milliseconds: 400),
                          context: context,
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return Dialog.fullscreen(
                                child: Column(
                                  children: [
                                    AddSourceScreen().build(context)
                                  ],
                                )
                            );
                          }
                      ),
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
          const Divider(color: Colors.grey,),
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
          )


        ],
      ),
    );

  }
}
