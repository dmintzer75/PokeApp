import 'package:flutter/material.dart';
import '../widgets/texts.dart';

class PokemonType extends StatelessWidget {
  const PokemonType({
    super.key,
    required this.types,
    required this.backgroundColor,
  });
  final Color backgroundColor;
  final List<String> types;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TypeCard(types[0], backgroundColor),
        const SizedBox(
          height: 4,
        ),
        if (types.length > 1) TypeCard(types[1], backgroundColor),
      ],
    );
  }
}

class TypeCard extends StatelessWidget {
  const TypeCard(
    this.type,
    this.backgroundColor, {
    this.fontWeight = FontWeight.normal,
    super.key,
  });
  final Color backgroundColor;
  final FontWeight fontWeight;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: backgroundColor,
      ),
      child: Text(
        type,
        style: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: fontWeight),
      ),
    );
  }
}
