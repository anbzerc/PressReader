import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pressreaderflutter/services/updateFileConteningSources.dart';

import '../models/RssSourceModel.dart';
import '../services/database.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              children: [
                MaterialButton(onPressed:() => updateFileConteningSources().downloadFile(), child: Text("Mettre à jour les sources"),),
                MaterialButton(onPressed:() => DatabaseService.instance.DeleteRssSource(RssSourceModel(name: "Le Figaro",isparsingsupported: true, imagepath: "imagePath", url: "url", rubriques: ["rubriques"], rss: ["rss"])), child: Text("lE FIGARO"),),
                MaterialButton(onPressed:() => DatabaseService.instance.DeleteRssSource(RssSourceModel(name: "Opex360", imagepath: "imagePath",isparsingsupported: true, url: "url", rubriques: ["rubriques"], rss: ["rss"])), child: Text("Opex360"),)
              ],
            )
        )
      ],
    ),);
  }
}
