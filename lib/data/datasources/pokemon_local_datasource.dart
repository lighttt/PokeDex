import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pokedexapp/core/error/exceptions.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';
import 'package:pokedexapp/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedexapp/domain/repositories/pokemon_repository.dart';

import 'package:pokedexapp/data/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalPokemonDataSource {
  Future<UnmodifiableListView<PokemonModel>> getPokemonList();

  Future<void> setPokemonList(String pokemonResponse);
}

const CACHED_POKEMONS = 'CACHED_POKEMONS';

class LocalPokemonDataSourceImpl implements LocalPokemonDataSource {
  final SharedPreferences sharedPreferences;

  LocalPokemonDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<UnmodifiableListView<PokemonModel>> getPokemonList() async {
    final jsonString = sharedPreferences.getString(CACHED_POKEMONS);
    if (jsonString != null) {
      List<dynamic> responseList = jsonDecode(jsonString);
      List<PokemonModel> pokemons = List<PokemonModel>.from(
          responseList.map((pokemon) => PokemonModel.fromJson(pokemon)));
      return Future.value(UnmodifiableListView(pokemons));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> setPokemonList(String pokemonResponse) {
    return sharedPreferences.setString(
        CACHED_POKEMONS, pokemonResponse);
  }
}
