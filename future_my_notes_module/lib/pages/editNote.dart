import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:FutureMyNotes/other/helperEditNote.dart';
import 'package:FutureMyNotes/other/NoteStorage.dart';
import 'package:FutureMyNotes/other/IconNoteStorage.dart';
import 'package:FutureMyNotes/obj/editNotePopup.dart';
import 'package:FutureMyNotes/obj/note.dart';
import 'package:FutureMyNotes/obj/DataInNote.dart';
import 'package:FutureMyNotes/other/helper.dart';

class EditNote extends StatefulWidget {
  EditNote({Key? key, required this.localNote}) : super(key: key);

  final Note localNote;
  final NoteStorage storageNote = NoteStorage();
  final IconsStorage storageIcons = IconsStorage();

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  late File imageFile = File("");
  late String nameNewNote = "";

  late List<dynamic> listData = [];
  late List<DataInNote> list = [];

  @override
  void initState() {
    super.initState();
    getData();
    getIcon();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: InkWell(
          onTap: () async {
            var imageFilePath = await ImagePicker().pickImage(source: ImageSource.gallery);
            setState(() {
              imageFile = File(imageFilePath!.path);
            });
          },
          child:
            imageFile.path.isNotEmpty ?
              Image.file(imageFile, height: 50.0, fit:BoxFit.fill)
            :
              Icon(Icons.note,color: Colors.white, size: 50.0)
        ),
        actions: <Widget>[
          new PopupMenuButton(
            color: Colors.grey[850],
            icon: Icon(Icons.add, color: Colors.white),
            itemBuilder: (BuildContext context){
              return editNotePopupList.map((EditNotePopup popup){
                return new PopupMenuItem(
                  value: popup.title.data,
                  child: ListTile(
                    leading: popup.ico,
                    title: popup.title,
                  )
                );
              }).toList();
            },
            onSelected: _selectAddNewElement,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          Text("Назва нотатку:"),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8, top: 4),
            decoration: BoxDecoration(
              color: Colors.red[900], borderRadius:  BorderRadius.circular(32),
            ),
            child:
            TextFormField(
              initialValue: Note.parseDataInViews(widget.localNote.getName),
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
          Text("Вміст нотатку:"),
          Divider(
            color: Colors.black,
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return EditNoteList(context, list, index, _deleteEditItem, _changeImage);
              }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        child: Icon(Icons.save,color: Colors.white),
        onPressed: () => _saveEditNote(),
      ),
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
  void getIcon() async {
    var file = await widget.storageIcons.getFile(widget.localNote.getName);
    if(await file.exists()){
      setState(() {
        imageFile = file;
      });
    }
  }
  Future<void> _selectAddNewElement(String el) async {
    DataInNote loc = DataInNote(type: "text", data: "");
    switch(el){
      case 'Добавити текст':
        loc = DataInNote(type: "text", data: "");
        break;
      case 'Добавити картинку':
        var imageFilePath = await ImagePicker().pickImage(source: ImageSource.gallery);
        final bytes = File(imageFilePath!.path).readAsBytesSync();
        String _img64 = base64Encode(bytes);
        loc = DataInNote(type: "image", data: _img64);
        break;
    }
    setState(() {
      list.add(loc);
    });
  }
  void _saveEditNote() async {
    if(nameNewNote.isNotEmpty){
      File localFile = await widget.storageNote.getFile(widget.localNote.getName);
      changeFileNameOnly(localFile, Note.parseDataInString(nameNewNote));
      widget.localNote.name = Note.parseDataInString(nameNewNote);
    }
    if(imageFile.path.isNotEmpty){
      String name = widget.localNote.name;
      widget.storageIcons.createFile(name);
      var data = await imageFile.readAsBytes();
      widget.storageIcons.writeFile(name, data);
    }
    list.forEach((element) {
      element.data = Note.parseDataInString(element.data);
    });
    String jsonData = json.encode(list);
    widget.storageNote.writeFile(widget.localNote.name, jsonData);
    ViewSnack(context, "Нотатка збережена!", true);

    Navigator.pop(context, 'Back');
    return Future.value(false);
  }
  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }
  void _deleteEditItem(int index){
    Navigator.pop(context, 'OK');
    setState(() {
      list.remove(list[index]);
    });
  }
  void _changeImage(int index) async {
    var imageFilePath = await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = File(imageFilePath!.path).readAsBytesSync();
    String _img64 = base64Encode(bytes);
    setState(() {
      list[index].data = _img64;
    });
  }
}