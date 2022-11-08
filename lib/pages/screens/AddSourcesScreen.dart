import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pressreaderflutter/models/RssSourceModel.dart';
import 'package:pressreaderflutter/services/LastArticle.dart';
import 'package:pressreaderflutter/services/database.dart';
import 'package:sqflite/sqflite.dart';

class AddSourceScreen extends StatelessWidget {
  AddSourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _addSource(context);
  }

  late Future<List<RssSourceModel>> sources;

  @override
  Widget _addSource(BuildContext context){
    sources=GetLastArticle().listeSources();
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: sources,
                builder: (context, snapshot){
                  if(snapshot.hasData) {
                    List<RssSourceModel> rssSource = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: rssSource.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                DatabaseService.instance.InsertRssSource(rssSource[index]);

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Image.asset(rssSource[index].imagepath, width: 90),
                                      Text(rssSource[index].name)
                                    ],),
                                ),
                              )
                          );
                        },),
                    );

                  }else if (snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  } else if(snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {return Text("rien");}
                }
            ),
          ),
        ],
      ),
    );
  }
}
