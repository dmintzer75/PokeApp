import 'package:flutter/material.dart';

// My files
import '../pages/home_screen.dart';
import '../pages/pokemon_details_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Pokedex());
}

class Pokedex extends StatelessWidget {
  const Pokedex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: ((context) => HomeScreen()),
        PokemonDetailsScreen.routeName: ((context) => PokemonDetailsScreen()),
      },
    );
  }
}
