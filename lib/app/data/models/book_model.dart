// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

List<BookModel> bookModelFromJson(List str) =>
    List<BookModel>.from(str.map((x) => BookModel.fromJson(x)));

class BookModel {
  String name;
  String bookPath;
  String audioPath;
  String imagePath;

  BookModel({
    required this.name,
    required this.bookPath,
    required this.audioPath,
    required this.imagePath,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        name: json["name"],
        bookPath: json["bookPath"],
        audioPath: json["audioPath"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "bookPath": bookPath,
        "audioPath": audioPath,
        "imagePath": imagePath,
      };
}
