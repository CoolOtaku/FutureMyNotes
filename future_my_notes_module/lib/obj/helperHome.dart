import 'package:flutter/material.dart';

import 'package:FutureMyNotes/obj/note.dart';
import 'package:intl/intl.dart';
import 'package:FutureMyNotes/pages/editNope.dart';

String nameNewNote = "";
String textNewNote = "";

void ViewSnack(BuildContext context, String text, bool isOk){
  var icon;
  if(isOk){
    icon = Icon(Icons.library_add_check_outlined, color: Colors.green, size: 35.0);
  }else{
    icon = Icon(Icons.cancel_outlined, color: Colors.red, size: 35.0);
  }

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      children: [
        icon,
        SizedBox(width: 5),
        Text(text)
      ],
    ),
  ));
}

AlertDialog ViewAddNewNotesDialog(BuildContext context, Function _createNewNote){
  return AlertDialog(
    backgroundColor: Colors.red[900],
    title: const Text('Створити нову нотатку'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
              color: Colors.grey[850], borderRadius:  BorderRadius.circular(32),
            ),
            child:
            TextFormField(
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Назва нотатки'
                ),
                onChanged: (text) {
                  nameNewNote = text;
                }
            )
        ),
        SizedBox(height: 10),
        Container(
            decoration: BoxDecoration(
              color: Colors.grey[850], borderRadius:  BorderRadius.circular(32),
            ),
            child:
            TextFormField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    hintText: 'Напишіть щось'
                ),
                onChanged: (text) {
                  textNewNote = text;
                }
            )
        ),
      ],
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.cancel, color: Colors.white),
        onPressed: () => Navigator.pop(context, 'Cancel'),
      ),
      IconButton(
        icon: Icon(Icons.save, color: Colors.white),
        onPressed: () => _createNewNote(context),
      ),
    ],
  );
}

Container CardNoteList(BuildContext context, List<Note> noteList, int index, Function _deleteNote){
  return Container(
    margin: EdgeInsets.only(left: 8, right: 8, top: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        colors: [
          Colors.red,
          Colors.black45,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.note,color: Colors.white, size: 50.0),
          title: Text(noteList[index].getName, style: TextStyle(color: Colors.white)),
          subtitle: Text(DateFormat('dd.MM.yyyy HH:mm:ss').format(noteList[index].getDate), style: TextStyle(color: Colors.white)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: Text('Редагувати', style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,decoration: TextDecoration.underline)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => EditNote(name: noteList[index].getName),
                ));
              },
            ),
            SizedBox(width: 5),
            IconButton(
              icon: Icon(Icons.delete,color: Colors.white),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => DeleteNoteDialog(context, _deleteNote, noteList[index].getName),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ],
    ),
  );
}

AlertDialog DeleteNoteDialog(BuildContext context, Function _deleteNote, String name){
  return AlertDialog(
    backgroundColor: Colors.red[900],
    title: const Text('Видалення нотатки!'),
    content: const Text('Ви дійсно хочете видалити дану нотатку?', style: TextStyle(color: Colors.white)),
    actions: <Widget>[
      TextButton(
        child: const Text('Ні',style: TextStyle(color: Colors.white)),
        onPressed: () => Navigator.pop(context, 'Cancel'),
      ),
      TextButton(
        child: const Text('Так',style: TextStyle(color: Colors.white)),
        onPressed: () => _deleteNote(context, name),
      ),
    ],
  );
}