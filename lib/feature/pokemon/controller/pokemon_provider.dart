import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedexapp/core/usecases/usecase.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';
import 'package:pokedexapp/domain/usecases/get_pokemons_usecase.dart';

class PokemonProvider with ChangeNotifier {
  final GetPokemonListUseCase getPokemonListUseCase;

  UnmodifiableListView<PokemonModel> _pokemonList = UnmodifiableListView([]);

  PokemonProvider({@required this.getPokemonListUseCase});

  UnmodifiableListView<PokemonModel> get pokemonList => _pokemonList;


  Future<void> getPokemonData() async {
    final response = await getPokemonListUseCase.call(NoParams());
    response.fold((failure) {
     throw Error();
    }, (pokemonList) {
      _pokemonList = pokemonList;
      notifyListeners();
    });
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
