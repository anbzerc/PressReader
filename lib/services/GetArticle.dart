import 'package:flutter/material.dart';
import 'package:pressreaderflutter/media/Lefigaro.dart';
import 'package:pressreaderflutter/media/opex360.dart';
import 'package:pressreaderflutter/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GetArticle extends StatelessWidget {
  final ListeArticle listeArticle;

  const GetArticle({Key? key, required this.listeArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget GetArticleByMediaName() {
    if(listeArticle.url.contains('www.lefigaro.fr')){
        return SafeArea(child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: FutureBuilder(
                future: LeFigaroArticle(listeArticle.url),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const ArticleLayout().articlelayout(snapshot.data!, context);
                  } else
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return WebView(initialUrl: snapshot.data!.url);
                  }
                }
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            height: 15,
            child: Row(children: const [

              IconButton(onPressed: null,
                  icon: Icon(Icons.bookmarks_outlined, color: Colors.grey,),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(5, 5, 15, 5)),

            ],),
          ),
        ));
    }


      else if(listeArticle.url.contains('www.opex360.com')){
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: FutureBuilder(
                  future: opex360Article(listeArticle.url),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const ArticleLayout().articlelayout(snapshot.data!, context);
                    } else
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return WebView(initialUrl: snapshot.data!.url);
                    }
                  }
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              height: 15,
              child: Row(children: const [

                IconButton(onPressed: null,
                    icon: Icon(Icons.bookmarks_outlined, color: Colors.grey,),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(5, 5, 15, 5)),

              ],),
            ),
          ),
        );
      }

      else{
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: WebView(
                  initialUrl: listeArticle.url,
                  ),
            ),

            bottomNavigationBar: BottomAppBar(
              height: 15,
              child: Row(children: const [

                IconButton(onPressed: null,
                    icon: Icon(Icons.bookmarks_outlined, color: Colors.grey,),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(5, 5, 15, 5)),

              ],),
            ),
          ),
        );
      }
    }
  }

