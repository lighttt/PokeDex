import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedexapp/core/error/exceptions.dart';
import 'package:pokedexapp/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fixtures/fixture_reader.dart';
import 'pokemon_local_datasource_test.mocks.dart';

@GenerateMocks([
  SharedPreferences
], customMocks: [
  MockSpec<SharedPreferences>(
      as: #MockSharedPreferencesForTest, returnNullOnMissingStub: true),
])
void main() {
  LocalPokemonDataSource dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        LocalPokemonDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getPokemonList', () {
    final tPokemonList = List<PokemonModel>.from(json
        .decode(fixture('pokemon.json'))
        .map((pokemon) => PokemonModel.fromJson(pokemon)));
    test(
        'should return PokemonList from SharedPreferences when there is one in the cache',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('pokemon.json'));
      //act
      final result = await dataSource.getPokemonList();
      //assert
      verify(mockSharedPreferences.getString(CACHED_POKEMONS));
      expect(result, equals(tPokemonList));
    });

    test('should throw a CacheException when there is not a cached value',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = dataSource.getPokemonList();
      //assert
      expect(() => call, throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('setPokemonList', () {
    final tPokemonList = '';
    test('should call SharedPreferences to cache the data', () async {
      //act
      dataSource.setPokemonList(tPokemonList);
      //assert
      verify(mockSharedPreferences.setString(CACHED_POKEMONS, tPokemonList));
    });
  });
}
