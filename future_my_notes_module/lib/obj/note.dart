import 'dart:io';

class Note{

  String name;
  DateTime date;
  File file;

  Note(this.name, this.date, this.file);

  String get getName => this.name;
  DateTime get getDate => this.date;
  File get getPath => this.file;

}