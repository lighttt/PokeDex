import 'package:flutter/material.dart';
import 'package:pokedexapp/providers/pokemon_provider.dart';
import 'package:pokedexapp/screens/pokemon_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PokemonProvider(),
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        home: PokemonListScreen(),
      ),
    );
  }
}
