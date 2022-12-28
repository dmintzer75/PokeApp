import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:searchfield/searchfield.dart';

// My Files
import '../models/pokemon.dart';
import '../theme/custom_theme.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/texts.dart';
import '../widgets/pokemon_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static final routeName = '/';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final theme = CustomTheme.portfolioTheme;
  final pokeApi = 'https://pokeapi.co/api/v2/pokemon/';
  List pokemons = [];
  String? _selectedPokemon;
  List<String> pokemonNames = [];

  @override
  void initState() {
    super.initState();
    if (mounted) {
      startLoadingData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: pokemons.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator(color: theme.colorScheme.primary),
            )
          : Stack(
              children: [
                Positioned(
                  top: 60,
                  right: 20,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset('assets/pokedex_grey.png',
                        height: 140, fit: BoxFit.fitHeight),
                  ),
                ),
                const Positioned(
                  top: 120,
                  left: 40,
                  child: Text(
                    'Pokedex',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Positioned(
                  top: 170,
                  bottom: 0,
                  width: widthDevice,
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.4,
                            crossAxisCount: 2,
                          ),
                          itemCount: pokemons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PokemonCard(
                                pokemons: pokemons, index: index);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                // Positioned(
                //   top: 100,
                //   left: 10,
                //   child: SizedBox(
                //     width: 250,
                //     child: SearchField(
                //       hint: 'Search for a Pokemon',
                //       onSubmit: (pokemon) {
                //         setState(() {
                //           _selectedPokemon = pokemon;

                //           for (var i = 0; i < pokemons.length; i++) {
                //             if (pokemons[i].name == _selectedPokemon) {
                //               pokemons = [pokemons[i]];
                //             }
                //           }
                //         });
                //       },
                //       suggestions: pokemonNames
                //           .map((e) => SearchFieldListItem(e, child: Text(e)))
                //           .toList(),
                //       searchStyle: TextStyle(
                //         fontSize: 18,
                //         color: Colors.black.withOpacity(0.8),
                //       ),
                //       searchInputDecoration: InputDecoration(
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(
                //             color: Colors.black.withOpacity(0.8),
                //           ),
                //         ),
                //         border: const OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.red),
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
    );
  }

  // HELPER FUNCTIONS -------------------------------------------------------

  void filterPokemon(String? s) {
    List<String> filteredPokemon = pokemonNames;
    pokemons.where((element) => element.name == s);
    setState(() {});
  }

  Future<void> fetchData() async {
    pokemons.clear();

    final url = Uri.https('pokeapi.co', '/api/v2/pokemon/', {'limit': '12'});

    final response = await http.get(url);
    final decoded = convert.jsonDecode(response.body);
    for (int i = 0; i < decoded['results'].length; i++) {
      String singlePokemonUrl = decoded['results'][i]['url'];
      final pokemonResponse = await http.get(Uri.parse(singlePokemonUrl));
      final decodedPokemon = convert.jsonDecode(pokemonResponse.body);

      // Generate Stats
      Map<String, int> stats = {};
      for (var i = 0; i < 6; i++) {
        stats[decodedPokemon['stats'][i]['stat']['name']] =
            decodedPokemon['stats'][i]['base_stat'];
      }
      // Generate Moves
      List<String> moves = [
        capitalize(decodedPokemon['moves'][0]['move']['name']),
        capitalize(decodedPokemon['moves'][1]['move']['name'])
      ];
      // Generate Type/s
      List<String> types = List.generate(
        decodedPokemon['types'].length,
        (index) => capitalize(decodedPokemon['types'][index]['type']['name']),
      );

      pokemons.add(
        Pokemon(
            name: capitalize(decodedPokemon['name']),
            id: decodedPokemon['id'],
            height: decodedPokemon['height'],
            weight: decodedPokemon['weight'],
            imageUrl: decodedPokemon['sprites']['front_default'],
            types: types,
            moves: moves,
            stats: stats),
      );
      pokemonNames.add(capitalize(decodedPokemon['name']));
    }

    setState(() {});
  }

  void fetchRestOfData() async {
    for (int i = pokemons.length + 1; i <= 151; i++) {
      final url = Uri.https('pokeapi.co', '/api/v2/pokemon/${i.toString()}');
      final response = await http.get(url);
      final decodedPokemon = convert.jsonDecode(response.body);

      // Generate Stats
      Map<String, int> stats = {};
      for (var i = 0; i < 6; i++) {
        stats[decodedPokemon['stats'][i]['stat']['name']] =
            decodedPokemon['stats'][i]['base_stat'];
      }
      // Generate Moves
      List<String> moves = [
        capitalize(decodedPokemon['moves'][0]['move']['name']),
        capitalize(decodedPokemon['moves'][1]['move']['name'])
      ];
      // Generate Type/s
      List<String> types = List.generate(
        decodedPokemon['types'].length,
        (index) => capitalize(decodedPokemon['types'][index]['type']['name']),
      );

      pokemons.add(
        Pokemon(
            name: capitalize(decodedPokemon['name']),
            id: decodedPokemon['id'],
            height: decodedPokemon['height'],
            weight: decodedPokemon['weight'],
            imageUrl: decodedPokemon['sprites']['front_default'],
            types: types,
            moves: moves,
            stats: stats),
      );
      pokemonNames.add(capitalize(decodedPokemon['name']));
      setState(() {});
    }
  }

  void startLoadingData() async {
    await fetchData().then((_) => fetchRestOfData());
  }

  String capitalize(String word) {
    if (word.trim().isEmpty) return "";

    return "${word[0].toUpperCase()}${word.substring(1)}";
  }
}
