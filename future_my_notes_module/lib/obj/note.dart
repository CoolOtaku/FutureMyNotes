import 'dart:io';

import 'dart:math';

class Note{

  String name;
  String size_date;
  File icon;

  Note(this.name, this.size_date, this.icon);

  String get getName => this.name;
  String get getSize_Date => this.size_date;
  File get getIcon => this.icon;

  static String parseDataInString(String data){
    data = data.replaceAll("'", "‘");
    data = data.replaceAll("\"", "″");
    data = data.replaceAll("\n", "‰");
    return data;
  }

  static String parseDataInViews(String data){
    data = data.replaceAll("‰", "\n");
    return data;
  }

  static Future<String> getFileSize(int bytes) async {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(1)) + ' ' + suffixes[i];
  }

}