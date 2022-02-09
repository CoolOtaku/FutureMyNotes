import 'package:flutter/material.dart';

import 'package:FutureMyNotes/obj/NoteStorage.dart';
import 'package:FutureMyNotes/obj/note.dart';

class EditNote extends StatefulWidget {
  EditNote({Key? key, required this.name}) : super(key: key);

  final String name;
  final NoteStorage storage = NoteStorage();

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text(widget.name),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Container(

      ),
    );
  }
}
