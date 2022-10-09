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

  String paragraph (){
    var head = document.split("<head>")[1].toString().split("</head>")[0];
    var body = document.substring(document.split("<body ")[1].indexOf('">'), document.split("<body ")[1].indexOf("</body>"));//.split("</head>")[0];
    var contenufinal = "";
    var ListeContenuFinal = document.split('<p class="fig-paragraph">').toList();
    var index = 0;
    for (var element in ListeContenuFinal) {
      if (index>=1) {
        if(element.contains("blockquote") || element.contains("platform.twitter")){
          //todo
        }
          contenufinal = contenufinal + element.split("<a ")[0] + element.split("<a ")[1].split('">')[1].
          replaceAll("</a>", "").replaceAll("</p>", "\n").
          replaceAll("&nbsp;", " ").replaceAll("&shy;", "").
          replaceAll("&amp;", "&").replaceAll('<div class="swp-content-locator"></div>', "");

        }
        else {
          contenufinal = contenufinal +
              element.toString();/*.replaceAll("</p>", "\n").replaceAll(
                  "&nbsp;", " ").replaceAll("&shy;", "").replaceAll(
                  "&amp;", "&").replaceAll(
                  '<div class="swp-content-locator"></div>', "");*/

        }
        index=index+1;
      }
    return contenufinal;
    }

  }
