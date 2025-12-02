import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pokedexapp/core/usecases/usecase.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';
import 'package:pokedexapp/domain/usecases/get_pokemons_usecase.dart';

class PokemonProvider with ChangeNotifier {
  final GetPokemonListUseCase getPokemonListUseCase;

  UnmodifiableListView<PokemonModel> _pokemonList = UnmodifiableListView(const []);

  PokemonProvider({required this.getPokemonListUseCase});

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
    final index = _pokemonList.indexWhere((element) => element.id == id);
    if (index == -1) return;
    final updated = _pokemonList[index].copyWith(isFavourite: !_pokemonList[index].isFavourite);
    final mutableList = _pokemonList.toList();
    mutableList[index] = updated;
    _pokemonList = UnmodifiableListView(mutableList);
    notifyListeners();
  }

  List<PokemonModel> getFavourites() {
    return _pokemonList.where((pokemon) => pokemon.isFavourite).toList();
  }

  List<PokemonModel> getSearchResults(String query) {
    return _pokemonList.where((pokemon) => pokemon.name.toLowerCase().startsWith(query.toLowerCase())).toList();
  }
}
