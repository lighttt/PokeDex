import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedexapp/model/pokemon_model.dart';

class PokemonProvider with ChangeNotifier {
  List<PokemonModel> _pokemonList = [];

  List<PokemonModel> get pokemonList => _pokemonList;

  Future<void> getPokemonData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://gist.githubusercontent.com/lighttt/20e03ef249cc9b3ab5496b777c6f066f/raw/b27d2dce021d3b1f906f47bdbf574ffba62c1ded/pokeapi.json'));
      List<dynamic> responseList = jsonDecode(response.body);
      _pokemonList = List<PokemonModel>.from(
          responseList.map((pokemon) => PokemonModel.fromJson(pokemon)));
    } catch (error) {
      print(error);
    }
  }

  PokemonModel getPokemonById(String id) {
    return _pokemonList.firstWhere((pokemon) => pokemon.id == id);
  }

  void toggleFavourite(String id) {
    int index = _pokemonList.indexWhere((element) => element.id == id);
    _pokemonList[index].isFavourite = !_pokemonList[index].isFavourite;
    notifyListeners();
  }

  List<PokemonModel> getFavourites() {
    return _pokemonList.where((pokemon) => pokemon.isFavourite).toList();
  }

  List<PokemonModel> getSearchResults(String query) {
    return _pokemonList
        .where((pokemon) =>
            pokemon.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
  }
}
