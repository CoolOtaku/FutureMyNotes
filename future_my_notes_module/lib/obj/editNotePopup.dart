import 'package:flutter/material.dart';

const List<EditNotePopup> editNotePopupList = <EditNotePopup>[
  const EditNotePopup(Icon(Icons.text_fields, color: Colors.white), Text('Добавити текст', style: TextStyle(color: Colors.white))),
  const EditNotePopup(Icon(Icons.image, color: Colors.white), Text('Добавити картинку', style: TextStyle(color: Colors.white))),
];

class EditNotePopup{

  final Icon ico;
  final Text title;

  const EditNotePopup(this.ico, this.title);

}
