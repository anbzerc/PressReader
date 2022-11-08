import 'package:flutter/material.dart';
import 'package:pressreaderflutter/services/GetArticle.dart';


import '../models/article.dart';

class ListArticleLayout extends StatelessWidget {
  final Future<List<ListeArticle>> listeArticle;
  const ListArticleLayout({Key? key, required this.listeArticle}) : super(key: key);

  @override
  Widget build(BuildContext context, ) {
    return Center(
      child: FutureBuilder<List<ListeArticle>>(
          future: listeArticle,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(semanticsLabel: "Chargement..."),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
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
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context, MaterialPageRoute(builder: (context) =>
                                    GetArticle(listeArticle: snapshot.data![index]).GetArticleByMediaName()
                                )
                                ),
                                child: const ItemListeArticleLayout().ListViewArticleLayout(snapshot.data![index], context),
                                //Text(snapshot.data![index].urlimage),
                              );
                            }
                        )
                    ),
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
