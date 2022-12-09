import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class renderFromHTML extends StatelessWidget {
  const renderFromHTML({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Future<Widget> render(String url) async {
    final client = Dio();
    try {
      client.options.connectTimeout = 10000;
      final response = await client.get(url);
      final html = response.data.toString();
      return SingleChildScrollView(child: Column(
        children: [
          HtmlWidget(html, customWidgetBuilder: (element) {
              if(element.toString().startsWith("<html div")){
                var elementschildren = element.children;
                return Text("$element");
              }
          }, )
        ],
      ));
    } catch(e) {
      return Column();
    }
  }
}
