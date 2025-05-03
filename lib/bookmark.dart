//import 'package:flutter/material.dart';
class Bookmark{
Bookmark({
  required this.title,required this.urlToImage,required this.description,
});
final String title;
final String urlToImage;
final String description;

Map<String,dynamic> toMap(){
  return {
    'title':title,
    'urlToImage':urlToImage,
    'description':description,
  };
}

static Bookmark fromMap(Map<String,dynamic> map){
  return Bookmark(title: map['title'], urlToImage: map['urlToImage'], description: map['description']);
}

}