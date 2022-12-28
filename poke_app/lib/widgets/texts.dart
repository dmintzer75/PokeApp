import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonName extends StatelessWidget {
  const PokemonName(this.name, {this.fontSize = 18});
  final String name;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: GoogleFonts.poppins(
          fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle(
      {super.key,
      required this.text,
      this.fontSize = 18,
      this.color = Colors.black});
  final String text;
  final double fontSize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
    );
  }
}
