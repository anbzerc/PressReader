import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pressreaderflutter/models/RssSourceModel.dart';

import '../services/database.dart';

AppBar MediaAppBar(RssSourceModel rssSource, BuildContext context){
  var appbar = AppBar(
    actions: [

      IconButton(onPressed: () {
        DatabaseService.instance.DeleteRssSource(rssSource);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Source ${rssSource.name} suprimée", textAlign: TextAlign.center),
            duration: const Duration(seconds: 2),
          ),
        );
      }, icon: const Icon(Icons.star_outlined,))],
    title: SizedBox(
        width: 100,
        child: Image.asset(rssSource.imagepath)),
    centerTitle: true,
  );
  return appbar;

}