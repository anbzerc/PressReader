
import 'dart:convert';

import 'package:flutter/services.dart';

class GetLastArticle{
  late List<String> _sources;
  late Map<String, List<List<String>>> _rss;
  Future<void> readJson () async {
    final String response = await rootBundle.loadString('assets/sources.json');
    final data = await jsonDecode(response);
    _sources = data["items"]["name"];

  }

}