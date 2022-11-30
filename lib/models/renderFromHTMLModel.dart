class renderFromHTMLModel {
  final String body;

  renderFromHTMLModel({
    required this.body
  });

  Map<String, dynamic> toMap(){
    return {
      "body" : body
    };
  }

  factory renderFromHTMLModel.fromMap(Map<String, dynamic> map) {
    return renderFromHTMLModel(body: map['body']);
  }
}