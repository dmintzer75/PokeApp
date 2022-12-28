// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

// My Files
import '../widgets/pokemon_type.dart';
import '../widgets/texts.dart';
import '../pages/home_screen.dart';
import '../models/pokemon.dart';
import '../theme/custom_theme.dart';

class PokemonDetailsScreen extends StatelessWidget {
  const PokemonDetailsScreen({super.key});
  static final routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final theme = CustomTheme.portfolioTheme;
    // Getting the arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    final pokemons = args['pokemons'];
    final pokemonIndex = args['index'];
    final Pokemon pokemon = pokemons[pokemonIndex];
    // Specifying what i need
    final List<String> types = pokemon.types;
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pushNamed(
            context,
            HomeScreen.routeName,
          ),
        ),
        centerTitle: false,
        title: PokemonName(
          pokemon.name,
          fontSize: 24,
        ),
        backgroundColor: pokemon.getColor(types[0]),
        elevation: 0,
      ),
      backgroundColor: pokemon.getColor(types[0]),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset('assets/pokeball.png',
                  height: 180, fit: BoxFit.fitHeight),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              margin: const EdgeInsets.all(10),
              width: widthDevice - 20,
              height: heightDevice * 0.7,
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
              child: PokemonInformation(types: types, pokemon: pokemon),
            ),
          ),
          if (pokemonIndex <= 151)
            Positioned(
              right: 80,
              top: 10,
              child: CachedNetworkImage(
                imageUrl: pokemon.imageUrl,
                height: 200,
                fit: BoxFit.fitHeight,
              ),
            ),
          if (pokemonIndex >= 1)
            Positioned(
              left: 10,
              top: 160,
              child: InkWell(
                child: Icon(
                  Icons.arrow_left_rounded,
                  color: pokemon.getColor(types[0]),
                  size: 100,
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PokemonDetailsScreen.routeName,
                    arguments: {
                      'index': pokemonIndex - 1,
                      'pokemons': pokemons
                    },
                  );
                },
              ),
            ),
          Positioned(
            right: 10,
            top: 160,
            child: InkWell(
              child: Icon(
                Icons.arrow_right_rounded,
                color: pokemon.getColor(types[0]),
                size: 100,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  PokemonDetailsScreen.routeName,
                  arguments: {'index': pokemonIndex + 1, 'pokemons': pokemons},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PokemonInformation extends StatelessWidget {
  const PokemonInformation({
    super.key,
    required this.types,
    required this.pokemon,
  });

  final List<String> types;
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TypeCard(
              types[0],
              pokemon.getColor(types[0]),
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(width: 4),
            if (types.length > 1)
              TypeCard(
                types[1],
                pokemon.getColor(types[1]),
                fontWeight: FontWeight.bold,
              ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Subtitle(
          text: 'About',
          fontSize: 24,
          color: pokemon.getColor(types[0]),
        ),
        const SizedBox(
          height: 20,
        ),
        MainAttributes(pokemon: pokemon),
        const SizedBox(
          height: 40,
        ),
        Subtitle(
          text: 'Base Stats',
          fontSize: 24,
          color: pokemon.getColor(types[0]),
        ),
        BaseStats(pokemon: pokemon, types: types),
      ],
    );
  }
}

class MainAttributes extends StatelessWidget {
  const MainAttributes({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/scale.png',
                    height: 30,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('${pokemon.weight.toString()} Kg'),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Weight',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ],
          ),
          VerticalDivider(
            width: 20,
            thickness: 2,
            color: Colors.grey[300],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/ruler.png',
                    height: 30,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('${pokemon.height.toString()} m'),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Height',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ],
          ),
          VerticalDivider(
            width: 20,
            thickness: 2,
            color: Colors.grey[300],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(pokemon.moves[0]),
              SizedBox(
                height: 4,
              ),
              Text(pokemon.moves[1]),
              SizedBox(
                height: 4,
              ),
              Text(
                'Moves',
                style: GoogleFonts.poppins(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BaseStats extends StatelessWidget {
  const BaseStats({super.key, required this.pokemon, required this.types});
  final Pokemon pokemon;
  final List<String> types;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: SizedBox(
        height: 170,
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...pokemon.stats.entries.map((stat) {
                  return Column(
                    children: [
                      Subtitle(
                        text: stat.key,
                        fontSize: 14,
                        color: pokemon.getColor(types[0]),
                      ),
                      SizedBox(
                        height: 1,
                      )
                    ],
                  );
                }).toList(),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            VerticalDivider(
              width: 20,
              thickness: 2,
              color: Colors.grey[300],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...pokemon.stats.entries.map((stat) {
                  return Column(
                    children: [
                      Subtitle(
                        text: standNumbers(stat.value),
                        fontSize: 14,
                        color: Colors.grey[600]!,
                      ),
                      SizedBox(
                        height: 1,
                      )
                    ],
                  );
                }).toList(),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...pokemon.stats.entries.map((stat) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 150,
                        child: LinearPercentIndicator(
                          animation: true,
                          animationDuration: 1000,
                          barRadius: Radius.circular(5),
                          progressColor: pokemon.getColor(types[0]),
                          backgroundColor:
                              pokemon.getColor(types[0]).withOpacity(0.2),
                          lineHeight: 12,
                          percent: (stat.value / 200),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper Functions
  String standNumbers(int number) {
    switch (number.toString().length) {
      case (1):
        return '00$number';
      case (2):
        return '0$number';
      case (3):
        return '$number';

      default:
        return '00$number';
    }
  }
}
