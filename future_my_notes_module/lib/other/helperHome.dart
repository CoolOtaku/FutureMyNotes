import 'package:flutter/material.dart';

import 'package:FutureMyNotes/obj/note.dart';
import 'package:FutureMyNotes/pages/editNote.dart';
import 'package:FutureMyNotes/pages/viewNote.dart';

String nameNewNote = "";
String textNewNote = "";

TextEditingController editingController = TextEditingController();

AlertDialog ViewAddNewNotesDialog(BuildContext context, Function _createNewNote){
  return AlertDialog(
    backgroundColor: Colors.grey[850],
    title: const Text('Створити нову нотатку'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red[900], borderRadius:  BorderRadius.circular(32),
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
            color: Colors.red[900], borderRadius:  BorderRadius.circular(32),
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

Dismissible CardNoteList(BuildContext context, List<Note> noteList, int index, Function _deleteNote){
  return Dismissible(
    key: Key(noteList[index].hashCode.toString()),
    child: Container(
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
            leading:
              noteList[index].getIcon.path.isNotEmpty ?
                Image.file(noteList[index].getIcon, height: 50.0, fit:BoxFit.fill)
              :
                Icon(Icons.note,color: Colors.white, size: 50.0),
            title: Text(noteList[index].getName, style: TextStyle(color: Colors.white)),
            subtitle: Text(noteList[index].getSize_Date, style: TextStyle(color: Colors.white)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: RichText(
                  text:TextSpan(
                    text: "📖 ",
                    style: DefaultTextStyle.of(context).style,
                    children: const <TextSpan>[
                      TextSpan(text:'Переглянути', style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,decoration: TextDecoration.underline))
                    ],
                  )
                ),
                onPressed: () {
                  //
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewNote(localNote: noteList[index]),
                  ));
                }
              ),
              SizedBox(width: 5),
              TextButton(
                child: RichText(
                  text:TextSpan(
                    text: "🖊️ ",
                    style: DefaultTextStyle.of(context).style,
                    children: const <TextSpan>[
                      TextSpan(text:'Редагувати', style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,decoration: TextDecoration.underline))
                    ],
                  )
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EditNote(localNote: noteList[index]),
                  ));
                },
              ),
              SizedBox(width: 5),
              IconButton(
                icon: Icon(Icons.delete,color: Colors.white),
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => DeleteNoteDialog(context, _deleteNote, noteList[index].getName, index),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    ),
    confirmDismiss: (DismissDirection dismissDirection) async {
      showDialog<String>(context: context,
        builder: (BuildContext context) => DeleteNoteDialog(context, _deleteNote, noteList[index].getName, index),
      );
      if(noteList[index] != null){
        return false;
      }else{
        return true;
      }
    },
  );
}

AlertDialog DeleteNoteDialog(BuildContext context, Function _deleteNote, String name, int index){
  return AlertDialog(
    backgroundColor: Colors.grey[850],
    title: const Text('Видалення нотатки!'),
    content: const Text('Ви дійсно хочете видалити дану нотатку?', style: TextStyle(color: Colors.white)),
    actions: <Widget>[
      TextButton(
        child: const Text('Ні',style: TextStyle(color: Colors.white)),
        onPressed: () => Navigator.pop(context, 'Cancel'),
      ),
      TextButton(
        child: const Text('Так',style: TextStyle(color: Colors.white)),
        onPressed: () => _deleteNote(context, name, index),
      ),
    ],
  );
}

AlertDialog SearchDialog(Function filterSearchResults){
  return AlertDialog(
    backgroundColor: Colors.transparent,
    content: TextField(
      onChanged: (value) {
        filterSearchResults(value);
      },
      controller: editingController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.red[900],
        labelText: "Шукати",
        hintText: "Текст для пошуку",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        )
      ),
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
    ),
  );
}
