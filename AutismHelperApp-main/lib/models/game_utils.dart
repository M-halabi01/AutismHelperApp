import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardpath = "images/hidden.jpg";
  // ignore: non_constant_identifier_names
  List<String> cards_list = [
    "images/circle.jpg",
    "images/triangle.jpg",
    "images/circle.jpg",
    "images/heart.jpg",
    "images/star.jpg",
    "images/triangle.jpg",
    "images/star.jpg",
    "images/heart.jpg",
  ];
  final int cardCount = 8;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
