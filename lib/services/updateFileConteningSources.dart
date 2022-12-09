import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';

class updateFileConteningSources {

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('$directory/sources.xml');
  }
  Future<File> downloadFile() async {
    await deleteFile();
    var req = await http.Client().get(Uri.parse("https://github.com/anbzerc/PressReader/blob/e3bd9e0d0da35acc644ba0b630d45de391ca086d/assets/sources.xml"));
    final directory = await getApplicationDocumentsDirectory();
    var file = File('$directory/sources.xml');
    return file.writeAsBytes(req.bodyBytes);
  }
  Future<int> deleteFile() async {
    try {
      final file = await _localFile;
      await file.delete();
      return 1;
    } catch (e) {
      return 0;
    }
  }
}