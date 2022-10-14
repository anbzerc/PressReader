
class HtmlParser {
  String document;
  HtmlParser({
    required this.document
});
  String date(){
    var head = document.split("<head>")[1].toString().split("</head>")[0];
    var date = head.split('<meta property="article:modified_time" content="')[1].split('">')[0];
    return date;
  }
  String auteur () {
    var head = document.split("<head>")[1].toString().split("</head>")[0];
    return head;
  }

  String href ({String? element}){
    var href = element!.toString().split('href="')[1].split('"')[0];
    return href;
  }

  String title (){
    var head = document.split("<head>")[1].toString().split("</head>")[0];
    var title = head.split("<title>")[1].split("</title>")[0];
    return title;
  }

  

  String src (){
    var src = document.split('src="')[1].split('"')[0];
    return src;
  }
  
  String description (){
    var head = document.split("<head>")[1].toString().split("</head>")[0];
    var description = head.split('<meta name="description" content="')[1].split('">')[0];
    return description;
  }
  String urlimage (){
    var head = document.split("<head>")[1].toString().split("</head>")[0];
    var urlimage = head.split('<meta property="og:image" content="')[1].split('">')[0];
    return urlimage;
  }
  String text (String document_to_text, {textClass:  "" }){
    var contenufinal = "";
    var ListeContenuFinal = List<String>.empty(growable: true);
    if (textClass=="") {
      var ListeContenuFinal = document_to_text.split('<p>') ;
    }else {
      var ListeContenuFinal = document_to_text.split('<p class="$textClass">') ;
    }
    for(var element in document_to_text.split('<p class="$textClass">')){

        contenufinal = contenufinal + element.replaceAll("</p>", "\n\n");

    }

    if(contenufinal.contains("<a")==true){
      var index = 0;
      var contenuparse = contenufinal.split("<a");
      var numberofa = contenuparse.length - 1;
      for(var element in contenuparse) {
        if (index !=0 ) {
          contenufinal = contenufinal.split("<a")[0] + element.split('">')[1].replaceAll('</a>', "") ;//+ contenufinalcopie.split("</a>")[1];

        }
        index = index + 1;
      }
      ;

    }
    contenufinal=contenufinal.replaceAll("&nbsp;", " ").replaceAll("&shy;", "").replaceAll("&amp;", "&").replaceAll("<em>", "").replaceAll("</em>", "");
    return contenufinal ;
    }

  }
