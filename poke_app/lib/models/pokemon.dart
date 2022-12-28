import 'package:flutter/material.dart';

class Pokemon {
  String name;
  int id;
  int height;
  int weight;
  String imageUrl;
  List<String> types;
  List<String> moves;
  Map<String, int> stats;

  Pokemon(
      {required this.name,
      required this.id,
      required this.height,
      required this.weight,
      required this.imageUrl,
      required this.types,
      required this.moves,
      required this.stats});

  Color getColor(String type) {
    switch (type) {
      case 'Grass':
        return Colors.green;
      case 'Flying':
        return Colors.indigo[300]!;
      case 'Fire':
        return Color(0xffEF8031);
      case 'Water':
        return Colors.blue;
      case 'Electric':
        return Colors.yellow[600]!;
      case 'Rock':
        return Color(0xffA38C22);
      case 'Poison':
        return Colors.purple[400]!;
      case 'Ground':
        return Colors.brown;
      case 'Normal':
        return Colors.grey[400]!;
      case 'Bug':
        return Color(0xff719F3E);
      case 'Fairy':
        return Colors.pink[200]!;
      case 'Fighting':
        return Color(0xffC03129);
      case 'Psychic':
        return Color(0xffF85887);
      case 'Dragon':
        return Color(0xffA27DF9);
      case 'Ice':
        return Colors.blue[200]!;
      case 'Ghost':
        return Colors.deepPurple;
      case 'Steel':
        return Colors.grey[300]!;

      default:
        return Colors.green;
    }
  }
}
