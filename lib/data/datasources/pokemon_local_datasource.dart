import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:pokedexapp/core/error/exceptions.dart';
import 'package:pokedexapp/data/dtos/pokemon_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalPokemonDataSource {
  Future<UnmodifiableListView<PokemonDTO>> getPokemonList();
  Future<void> setPokemonList(String pokemonResponse);
  Future<List<String>> getFavouriteIds();
  Future<void> saveFavouriteIds(List<String> ids);
}

const CACHED_POKEMONS = 'CACHED_POKEMONS';
const CACHED_FAVOURITES = 'CACHED_FAVOURITES';

class LocalPokemonDataSourceImpl implements LocalPokemonDataSource {
  final SharedPreferences sharedPreferences;

  LocalPokemonDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UnmodifiableListView<PokemonDTO>> getPokemonList() async {
    final jsonString = sharedPreferences.getString(CACHED_POKEMONS);
    if (jsonString != null) {
      List<dynamic> responseList = jsonDecode(jsonString);
      List<PokemonDTO> pokemons = List<PokemonDTO>.from(
          responseList.map((pokemon) => PokemonDTO.fromJson(pokemon)));
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

  @override
  Future<List<String>> getFavouriteIds() async {
    return sharedPreferences.getStringList(CACHED_FAVOURITES) ?? [];
  }

  @override
  Future<void> saveFavouriteIds(List<String> ids) {
    return sharedPreferences.setStringList(CACHED_FAVOURITES, ids);
  }
}
