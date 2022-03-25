import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:FutureMyNotes/other/NoteStorage.dart';
import 'package:FutureMyNotes/obj/note.dart';
import 'package:FutureMyNotes/obj/DataInNote.dart';

class ViewNote extends StatefulWidget {
  ViewNote({Key? key, required this.localNote}) : super(key: key);

  final Note localNote;
  final NoteStorage storageNote = NoteStorage();

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {

  List<dynamic> listData = [];
  List<DataInNote> list = [];
  var alignText = TextAlign.left;
  var alignRow= MainAxisAlignment.start;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.align_horizontal_left),
            onPressed: () => setState(() {
              alignText = TextAlign.left;
              alignRow = MainAxisAlignment.start;
            }),
          ),
          IconButton(
            icon: Icon(Icons.align_horizontal_center),
            onPressed: () => setState(() {
              alignText = TextAlign.center;
              alignRow = MainAxisAlignment.center;
            }),
          ),
          IconButton(
            icon: Icon(Icons.align_horizontal_right),
            onPressed: () => setState(() {
              alignText = TextAlign.right;
              alignRow = MainAxisAlignment.end;
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              margin: EdgeInsets.only(top: 8),
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
                      widget.localNote.getIcon.path.isNotEmpty ?
                        Image.file(widget.localNote.getIcon, height: 60.0, fit:BoxFit.fill)
                      :
                        Icon(Icons.note,color: Colors.white, size: 60.0),
                    title: Text(widget.localNote.getName, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            getWidgets()
          ],
        ),
      )
    );
  }

  void getData() async {
    String dataNote = await widget.storageNote.readFile(widget.localNote.getName);
    listData = json.decode(dataNote);
    listData.forEach((element) {
      DataInNote dataInNote = DataInNote.fromJson(element);
      setState(() {
        list.add(dataInNote);
      });
    });
    listData = [];
  }

  Widget getWidgets() {
    List<Widget> listWidget = [];
    for(var i = 0; i < list.length; i++){
      listWidget.add(new SizedBox(height: 8));
      list[i].type == 'text' ?
        listWidget.add(new Row(children:[Text(Note.parseDataInViews(list[i].data),textAlign:alignText)],mainAxisAlignment:alignRow))
      :
        listWidget.add(new InteractiveViewer(clipBehavior: Clip.none, child: Image.memory(base64Decode(list[i].data))));
    }
    listWidget.add(new SizedBox(height: 8));
    return new Column(children: listWidget);
  }

}