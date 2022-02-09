import 'package:path_provider/path_provider.dart';
import 'dart:io';

class NoteStorage {
  Future<String> GetNotesDir() async {
    return (await getApplicationDocumentsDirectory()).path+"/notes";
  }
  Future<File> getFile(String name) async {
    final directory = await GetNotesDir();
    return File('$directory/$name');
  }
  Future<File> createFile(String name) async {
    final directory = await GetNotesDir();
    return File('$directory/$name');
  }
  Future<void> deleteFile(String name) async {
    final file = await getFile(name);
    file.delete();
  }
  Future<File> writeFile(String name, String res) async {
    final file = await getFile(name);
    return file.writeAsString('$res');
  }
  Future<String> readFile(String name) async {
    try {
      final file = await getFile(name);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "null";
    }
  }
}