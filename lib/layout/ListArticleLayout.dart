import 'package:flutter/material.dart';
import 'package:pressreaderflutter/services/GetArticle.dart';
import 'package:animated_shimmer/animated_shimmer.dart';

import '../models/article.dart';

class ListArticleLayout extends StatefulWidget {
  final Future<List<ListeArticle>> listeArticle;
  const ListArticleLayout({Key? key, required this.listeArticle}) : super(key: key);

  @override
  State<ListArticleLayout> createState() => _ListArticleLayoutState();
}

class _ListArticleLayoutState extends State<ListArticleLayout> {
  bool isHover=false;
  @override
  Widget build(BuildContext context, ) {

    return Center(
      child: FutureBuilder<List<ListeArticle>>(
          future: widget.listeArticle,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
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
                                child:  ItemListeArticleLayout(snapshot.data![index]),
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
