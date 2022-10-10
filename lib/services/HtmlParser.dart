class HtmlParser {
  String document;
  HtmlParser({
    required this.document
});

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
  String paragraph (){
    var head = document.split("<head>")[1].toString().split("</head>")[0];
    var body = document.substring(document.split("<body ")[1].indexOf('">'), document.split("<body ")[1].indexOf("</body>"));//.split("</head>")[0];
    var contenufinal = "";
    var ListeContenuFinal = body.split('<p class="fig-paragraph">') ;
    var ElementContenuFinal = body.split('<p class="fig-paragraph">').toList().length-1;
    for(var index = 0; index < ElementContenuFinal; index = index+1){

        contenufinal = contenufinal + ListeContenuFinal[index+1].split("</p>")[0] + "\n";

    }

    /*if(contenufinal.contains("<a")==true){
      var index = 0;
      contenufinal.split("<a").forEach((element) {
        var contenufinalcopie = contenufinal;
        contenufinal = contenufinal.split("<a")[0] + contenufinalcopie.split("<a")[1].split(">")[1].split("</a>")[0] ;//+ contenufinalcopie.split("</a>")[1];
        index = index + 1;
      }
      );

    }*/
    contenufinal.replaceAll("&nbsp;", " ")
        .replaceAll("&shy;", "")
        .replaceAll("&amp;", "&")
        .replaceAll("<em>", "").replaceAll("</em>", "");
    return contenufinal;
    }

  }
