import 'package:flutter/material.dart';
import 'package:pressreaderflutter/layout/ListArticleLayout.dart';
import 'package:pressreaderflutter/media/Lefigaro.dart';
import 'package:pressreaderflutter/media/opex360.dart';
import 'package:pressreaderflutter/models/RssSourceModel.dart';
import 'package:pressreaderflutter/models/article.dart';
import 'package:pressreaderflutter/services/DefaultRssSource.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class GetListeArticle {
  Scaffold listeArticle(RssSourceModel rssSource) {

      switch (rssSource.url) {
        case 'https://www.lefigaro.fr' :
          return Scaffold(
            appBar: AppBar(
              title: Text(rssSource.name),
              centerTitle: true,
            ),
            body: LeFigaro(),
          );
        case 'http://www.lefigaro.fr' :
          return Scaffold(
            appBar: AppBar(
              title: Text(rssSource.name),
              centerTitle: true,
            ),
            body: LeFigaro(),
          );

        case 'http://www.opex360.com':
          return Scaffold(
            appBar: AppBar(
              title: Text(rssSource.name),
              centerTitle: true,
            ),
            body: Opex360State(urlpourlaliste: rssSource.url),
          );

        default:
          if (rssSource.rss.length != 1) {
            List<Text> text = List<Text>.generate(rssSource.rubriques.length,
                    (index) => Text(rssSource.rubriques[index]));
            List<String> urls = List<String>.generate(
                rssSource.rss.length, (index) => rssSource.rss[index]);
            List<Future<List<ListeArticle>>> ListOfFutureListeArticle = List<Future<List<ListeArticle>>>.generate(rssSource.rss.length,
                    (index) => DefaultRssSource(rssSource.rss[index]).ArticleList());

            return Scaffold(
                appBar: AppBar(

                  title: SizedBox(
                      width: 100,
                      child: Image.asset(rssSource.imagepath)),
                  centerTitle: true,
                ),
                body: DefaultTabController(
                  animationDuration: Duration.zero,
                  length: urls.length,
                  child: Column(
                    children: [
                      TabBar(
                        labelStyle: const TextStyle(fontSize: 18, fontFamily: "sansserif"),
                        indicatorWeight: 3,
                        indicator: MaterialIndicator(color: Colors.blue),
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                        splashFactory: NoSplash.splashFactory,
                        enableFeedback: true,
                        labelColor: Colors.black,
                        tabs: text,
                      ),
                      Expanded(
                        child: TabBarView(children: [
                          for (var index = 0; index <= urls.length-1; index++) ...[
                            ListArticleLayout(
                                listeArticle: ListOfFutureListeArticle[index])
                          ]
                        ]),
                      ),
                    ],
                  ),
                ));
          }else{
            return Scaffold(
              appBar: AppBar(title: Text(rssSource.name),),
              body: ListArticleLayout(listeArticle: DefaultRssSource(rssSource.rss.first).ArticleList()),
            );
          }


      }


  }
}
