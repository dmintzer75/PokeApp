import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// My Files
import '../pages/pokemon_details_screen.dart';
import '../models/pokemon.dart';
import '../theme/custom_theme.dart';
import '../widgets/texts.dart';
import '../widgets/pokemon_type.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    super.key,
    required this.index,
    required this.pokemons,
  });

  final int index;
  final List pokemons;

  Widget build(BuildContext context) {
    final Pokemon pokemon = pokemons[index];
    List<String> types = pokemon.types;
    Color color = pokemon.getColor(types[0]);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PokemonDetailsScreen.routeName,
            arguments: {'index': index, 'pokemons': pokemons});
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(25))),
        child: Stack(
          children: [
            Positioned(
              bottom: -15,
              right: -40,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset('assets/pokeball.png',
                    height: 120, fit: BoxFit.fitHeight),
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: PokemonName(
                pokemon.name,
              ),
            ),
            Positioned(
              right: -10,
              top: 42,
              child: CachedNetworkImage(
                imageUrl: pokemon.imageUrl,
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: PokemonType(
                types: types,
                backgroundColor: Colors.black.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
