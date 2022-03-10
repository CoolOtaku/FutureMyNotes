import 'package:path_provider/path_provider.dart';
import 'dart:io';

class IconsStorage {
  Future<String> GetIconsDir() async {
    return (await getApplicationDocumentsDirectory()).path+"/icons";
  }
  Future<File> getFile(String name) async {
    final directory = await GetIconsDir();
    return File('$directory/$name');
  }
  Future<File> createFile(String name) async {
    final directory = await GetIconsDir();
    return File('$directory/$name');
  }
  Future<void> deleteFile(String name) async {
    final file = await getFile(name);
    file.delete();
  }
  Future<File> writeFile(String name, var res) async {
    final file = await getFile(name);
    return file.writeAsBytes(res);
  }
}