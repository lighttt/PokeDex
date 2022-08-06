import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedexapp/core/usecases/usecase.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';
import 'package:pokedexapp/domain/usecases/get_pokemons_usecase.dart';

class PokemonProvider with ChangeNotifier {
  final GetPokemons getPokemons;

  List<PokemonModel> _pokemonList = [];

  PokemonProvider({@required this.getPokemons});

  List<PokemonModel> get pokemonList => _pokemonList;

  bool _isError = false;

  bool get isError => _isError;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> getPokemonData() async {
    _isLoading = true;
    notifyListeners();
    final response = await getPokemons.call(NoParams());
    response.fold((failure) {
      _isError = true;
    }, (pokemonList) => _pokemonList = pokemonList);
    _isLoading = false;
    notifyListeners();
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
