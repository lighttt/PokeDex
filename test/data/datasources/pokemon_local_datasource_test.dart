import 'dart:collection';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexapp/core/error/exceptions.dart';
import 'package:pokedexapp/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedexapp/data/dtos/pokemon_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fixture_reader.dart';

void main() {
  late SharedPreferences sharedPreferences;
  late LocalPokemonDataSourceImpl dataSource;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    dataSource = LocalPokemonDataSourceImpl(sharedPreferences: sharedPreferences);
  });

  group('getPokemonList', () {
    test('should return list when cache exists', () async {
      // arrange
      sharedPreferences.setString(CACHED_POKEMONS, fixture('pokemon.json'));
      // act
      final result = await dataSource.getPokemonList();
      // assert
      expect(result, isA<UnmodifiableListView<PokemonDTO>>());
      expect(result.first.id, '#001');
    });

    test('should throw CacheException when no cache', () async {
      // arrange -> no cache
      // act
      final call = dataSource.getPokemonList;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('setPokemonList', () {
    test('should cache the data', () async {
      // act
      await dataSource.setPokemonList(fixture('pokemon.json'));
      // assert
      expect(sharedPreferences.getString(CACHED_POKEMONS), fixture('pokemon.json'));
    });
  });

  group('favourites', () {
    test('should return empty list when no favourites', () async {
      final result = await dataSource.getFavouriteIds();
      expect(result, isEmpty);
    });

    test('should persist and retrieve favourite ids', () async {
      await dataSource.saveFavouriteIds(['#001', '#002']);
      final result = await dataSource.getFavouriteIds();
      expect(result, ['#001', '#002']);
    });
  });
}
