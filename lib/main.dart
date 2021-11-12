import 'package:flutter/material.dart';
import 'package:pokedexapp/pokemon_list_screen.dart';

void main() {
  runApp(PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: PokemonListScreen(),
    );
  }
}
