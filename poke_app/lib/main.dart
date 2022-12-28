import 'package:flutter/material.dart';

// My files
import '../pages/home_screen.dart';
import '../pages/pokemon_details_screen.dart';

void main() {
  runApp(const Pokedex());
}

class Pokedex extends StatelessWidget {
  const Pokedex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        PokemonDetailsScreen.routeName: ((context) => PokemonDetailsScreen()),
      },
    );
  }
}
