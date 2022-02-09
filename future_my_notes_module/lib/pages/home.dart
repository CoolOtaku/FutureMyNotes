import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:FutureMyNotes/obj/NoteStorage.dart';
import 'package:FutureMyNotes/obj/note.dart';
import 'package:FutureMyNotes/obj/helperHome.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  final NoteStorage storage = NoteStorage();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Directory dir = Directory("");
  List<Note> noteList = [];

@override
void initState() {
  super.initState();
  _getNotes();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        iconTheme: IconThemeData(
            color: Colors.white,
        ),
        leading:
        Container(
          margin: EdgeInsets.only(left: 8, bottom: 8, top: 8),
          child:
            Image.asset("src/img/logo.png"),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              var d = Directory(widget.storage.GetNotesDir().toString());
              if(d.existsSync()){
                ViewSnack(context, "NULL", false);
              }else{
                ViewSnack(context, "NOT NULL", true);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: noteList.length,
        itemBuilder: (BuildContext context, int index){
          return CardNoteList(context, noteList, index, _deleteNote);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        child: Icon(Icons.add,color: Colors.white),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => ViewAddNewNotesDialog(context, _createNewNote),
        ),
      ),
    );
}
  void _getNotes() async {
    noteList = [];
    dir = Directory(await widget.storage.GetNotesDir());
    if(!await dir.exists()){
      dir.create();
    }
    List fileList = dir.listSync();
    setState(() {
      fileList.forEach((element) {
        File file = File(element.toString());
        var stats = FileStat.statSync(file.path);
        var name = basename(file.path);
        name = name.replaceAll("'","");
        Note note = Note(name, DateTime.now(),file.absolute);
        noteList.add(note);
      });
    });
  }

  void _deleteNote(BuildContext context, String name){
    setState(() {
      Navigator.pop(context, 'OK');
      widget.storage.deleteFile(name);
      _getNotes();
    });
  }

  void _createNewNote(BuildContext context) async {
    if(nameNewNote.isEmpty){
      ViewSnack(context, "Ви не заповнили поле для імені нотатки!", false);
      return;
    }
    var ex = await File('${dir.path}/$nameNewNote').exists();
    if(!ex){
      nameNewNote = nameNewNote.replaceAll("'", "‘");
      textNewNote = textNewNote.replaceAll("'", "‘");
      widget.storage.createFile(nameNewNote);
      widget.storage.writeFile(nameNewNote, textNewNote);
      nameNewNote="";
      textNewNote="";
    }else{
      ViewSnack(context, "Нотатка з такою назвою уже існує!", false);
    }
    setState(() {
      _getNotes();
      Navigator.pop(context, 'OK');
    });
  }

}