import 'package:json_annotation/json_annotation.dart';

part 'DataInNote.g.dart';

@JsonSerializable()
class DataInNote{

  String type;
  String data;

  DataInNote({required this.type,required this.data});

  factory DataInNote.fromJson(Map<String, dynamic> json) => _$DataInNoteFromJson(json);

  Map<String, dynamic> toJson() => _$DataInNoteToJson(this);

}