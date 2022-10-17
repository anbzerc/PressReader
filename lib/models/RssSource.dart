class RssSources {

  final String name;
  final String image;
  final List<String> rss;
  final int length;
  //final bool HasParsingSupport;
  
  RssSources({
    required this.name,
    required this.image,
    required this.rss,
    required this.length,
    /* todo this.HasParsingSupport = false*/
  });

  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'icon' : image,
      'rss' : rss,
      'lenght' : length,
      /*'hasParsingSupport' : HasParsingSupport*/
    };
  }

  factory RssSources.fromMap(Map<String, dynamic> map) =>
      RssSources(name: map["name"],image: map['image'], rss: map["rss"], length: map["length"],/* HasParsingSupport: map["hasParsingSupport"]*/);

}