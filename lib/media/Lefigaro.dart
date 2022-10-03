import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:pressreaderflutter/article.dart';
import 'package:chaleno/chaleno.dart' ;

Future<Article> extractData(url) async {
//Getting the response from the targeted url
  final response = await Chaleno().load(url);

    var document = response?.html;
    try {
      //Scraping the first article title
      var titre = response?.getElementsByClassName("fig-standfirst")!.first.text!.trim();
      var description = response?.getElementsByClassName("fig-standfirst").first.text!.trim();
      var imageurl = response?.
      getElementsByClassName("fig-media fig-media--type-photo fig-media__content-main")
          .first.attr("srcset")!
          .trim().split(" ").first;
      var contenufinal = "";
      var auteurfinal = "Par ";
      var content = response?.getElementsByClassName("fig-paragraph");
      var content1 = content!.forEach((elements) => {
        contenufinal = contenufinal + elements.text.toString()
      });

      var auteurtmp  = response?.getElementsByClassName("fig-content-metas__author");
      if (auteurtmp!.isEmpty == false){var auteur1 = auteurtmp.forEach((element) { auteurfinal = auteurfinal + element.text.toString() + ", "; });}
      else {auteurfinal = "";}
      var date = response?.getElementsByClassName("fig-content-metas__pub-maj-date").first.text.toString();
      return Article(title: titre.toString(), auteur: auteurfinal.toString(), description: description.toString(), urlImage: imageurl.toString(), contenu: contenufinal, date: date.toString()) ;
    } catch (e) {
      return Article(title: 'Une erreur " $e " \n est survenue, veuillez réessayer"', auteur:"" , description: "", urlImage: "https://as2.ftcdn.net/v2/jpg/01/94/81/49/1000_F_194814992_UWnjXEu2WbIZefe9ZOAArxFRpVBG2u0M.jpg", contenu: "", date: "");
    }

  }


  

