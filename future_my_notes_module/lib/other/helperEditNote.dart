import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:FutureMyNotes/obj/note.dart';
import 'package:FutureMyNotes/obj/DataInNote.dart';

Dismissible EditNoteList(BuildContext context, List<DataInNote> list, int index, Function _deleteEditItem, Function _changeImage){
  return Dismissible(
    key: Key(list[index].hashCode.toString()),
    child: Container(
      margin: EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 4),
      decoration: BoxDecoration(
        color: Colors.red[900], borderRadius: BorderRadius.circular(32),
      ),
      child:
      list[index].type == 'text' ?
        TextFormField(
          initialValue: Note.parseDataInViews(list[index].data),
          maxLines: 3,
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
            list[index].data = text;
          }
        )
      :
        InkWell(
          onTap: () => _changeImage(index),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.memory(base64Decode(list[index].data)),
          ),
        ),
    ),
    confirmDismiss: (DismissDirection dismissDirection) async {
      showDialog<String>(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[850],
            title: const Text('Видалення'),
            content: const Text('Ви дійсно хочете видалити даний елемент?', style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              TextButton(
                child: const Text('Ні',style: TextStyle(color: Colors.white)),
                onPressed: () => Navigator.pop(context, 'Cancel'),
              ),
              TextButton(
                child: const Text('Так',style: TextStyle(color: Colors.white)),
                onPressed: () => _deleteEditItem(index),
              ),
            ],
          );
        },
      );
      if(list[index] != null){
        return false;
      }else{
        return true;
      }
    }
  );
}