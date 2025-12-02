import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pokedexapp/core/usecases/usecase.dart';
import 'package:pokedexapp/domain/entities/pokemon_entity.dart';
import 'package:pokedexapp/domain/usecases/get_pokemons_usecase.dart';
import 'package:pokedexapp/domain/usecases/save_favourites_usecase.dart';

enum PokemonStatus { initial, loading, success, failure }

class PokemonProvider with ChangeNotifier {
  final GetPokemonListUseCase getPokemonListUseCase;
  final SaveFavouriteIdsUseCase saveFavouriteIdsUseCase;

  UnmodifiableListView<PokemonEntity> _pokemonList = UnmodifiableListView(const []);
  PokemonStatus status = PokemonStatus.initial;
  String? errorMessage;

  PokemonProvider({required this.getPokemonListUseCase, required this.saveFavouriteIdsUseCase});

  UnmodifiableListView<PokemonEntity> get pokemonList => _pokemonList;
  bool get isLoading => status == PokemonStatus.loading;

  Future<void> getPokemonData() async {
    status = PokemonStatus.loading;
    notifyListeners();
    final response = await getPokemonListUseCase.call(NoParams());
    response.fold((failure) {
      status = PokemonStatus.failure;
      errorMessage = failure.message;
      notifyListeners();
    }, (pokemonList) {
      _pokemonList = pokemonList;
      status = PokemonStatus.success;
      notifyListeners();
    });
  }

  PokemonEntity getPokemonById(String id) {
    return _pokemonList.firstWhere((pokemon) => pokemon.id == id);
  }

  Future<void> toggleFavourite(String id) async {
    final index = _pokemonList.indexWhere((element) => element.id == id);
    if (index == -1) return;
    final current = _pokemonList[index];
    final updated = current.copyWith(isFavourite: !current.isFavourite);
    final mutableList = _pokemonList.toList();
    mutableList[index] = updated;
    _pokemonList = UnmodifiableListView(mutableList);
    notifyListeners();

    final favouriteIds = _pokemonList.where((p) => p.isFavourite).map((p) => p.id).toList();
    final result = await saveFavouriteIdsUseCase.call(SaveFavouriteIdsParams(favouriteIds));
    result.fold((failure) {
      // revert on failure
      mutableList[index] = current;
      _pokemonList = UnmodifiableListView(mutableList);
      status = PokemonStatus.failure;
      errorMessage = failure.message;
      notifyListeners();
    }, (_) {
      if (status == PokemonStatus.failure) {
        status = PokemonStatus.success;
      }
    });
  }

  List<PokemonEntity> getFavourites() {
    return _pokemonList.where((pokemon) => pokemon.isFavourite).toList();
  }

  List<PokemonEntity> getSearchResults(String query) {
    return _pokemonList.where((pokemon) => pokemon.name.toLowerCase().startsWith(query.toLowerCase())).toList();
  }
}
