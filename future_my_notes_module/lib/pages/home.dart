import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:FutureMyNotes/other/NoteStorage.dart';
import 'package:FutureMyNotes/other/IconNoteStorage.dart';
import 'package:FutureMyNotes/obj/note.dart';
import 'package:FutureMyNotes/other/helperHome.dart';
import 'package:FutureMyNotes/other/helper.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  final NoteStorage storage = NoteStorage();
  final IconsStorage storageIcons = IconsStorage();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Directory dir = Directory("");
  Directory dirIcons = Directory("");
  List<Note> noteList = [];
  List<Note> copyNoteList = [];

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
          leading: Container(
            margin: EdgeInsets.only(left: 8, bottom: 8, top: 8),
            child: Image.asset("src/img/logo.png"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.update),
              onPressed: () => _getNotes(),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showDialog(
                barrierColor: Colors.transparent,
                context: context,
                builder: (BuildContext context){
                  return SearchDialog(filterSearchResults);
                }
              ),
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
    copyNoteList = [];
    dir = Directory(await widget.storage.GetNotesDir());
    if(!await dir.exists()){
      dir.create();
    }
    dirIcons = Directory(await widget.storageIcons.GetIconsDir());
    if(!await dirIcons.exists()){
      dirIcons.create();
    }
    List fileList = dir.listSync();
    fileList.forEach((element) async {
      var stats = FileStat.statSync(element.path);
      var date = DateFormat('dd.MM.yyyy HH:mm:ss').format(stats.accessed);
      int bytes = element.lengthSync();
      var name = basename(element.path);
      name = name.replaceAll("'","");
      File icon = await widget.storageIcons.getFile(name);
      if(!await icon.exists()){
        icon = File("");
      }
      String sizeDate = "📅 "+date+" 💿 "+await Note.getFileSize(bytes);
      Note note = Note(name, sizeDate, icon);
      setState(() {
        noteList.add(note);
      });
      copyNoteList.add(note);
    });
  }

  void _deleteNote(BuildContext context, String name, int index){
    Navigator.pop(context, 'OK');
    widget.storage.deleteFile(name);
    setState(() {
      noteList.remove(noteList[index]);
    });
  }

  void _createNewNote(BuildContext context) async {
    if(nameNewNote.isEmpty){
      ViewSnack(context, "Ви не заповнили поле для імені нотатки!", false);
      return;
    }
    var ex = await File('${dir.path}/$nameNewNote').exists();
    if(!ex){
      nameNewNote = Note.parseDataInString(nameNewNote);
      textNewNote = Note.parseDataInString(textNewNote);
      widget.storage.createFile(nameNewNote);
      widget.storage.writeFile(nameNewNote, '[{"type":"text","data":"'+textNewNote+'"}]');
      nameNewNote="";
      textNewNote="";
    }else{
      ViewSnack(context, "Нотатка з такою назвою уже існує!", false);
    }
    Navigator.pop(context, 'OK');
    _getNotes();
  }

  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      setState(() {
        noteList.clear();
      });
      copyNoteList.forEach((item) {
        if(item.getName.contains(query) || item.getSize_Date.toString().contains(query)) {
          setState(() {
            noteList.add(item);
          });
        }
      });
      return;
    } else {
      setState(() {
        noteList.clear();
        noteList.addAll(copyNoteList);
      });
    }
  }

}