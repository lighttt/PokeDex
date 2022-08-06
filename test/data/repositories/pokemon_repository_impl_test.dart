import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedexapp/core/error/exceptions.dart';
import 'package:pokedexapp/core/error/failures.dart';
import 'package:pokedexapp/core/network/network_info.dart';
import 'package:pokedexapp/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedexapp/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';
import 'package:pokedexapp/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedexapp/domain/entities/pokemon_entity.dart';

import 'pokemon_repository_impl_test.mocks.dart';

class MockLocalDataSource extends Mock implements LocalPokemonDataSource {}

// class MockNetworkInfo extends Mock implements NetworkInfo {}

@GenerateMocks([NetworkInfo])
@GenerateMocks([
  RemotePokemonDataSource
], customMocks: [
  MockSpec<RemotePokemonDataSource>(
      as: #MockPokemonRemoteDataSourceForTest, returnNullOnMissingStub: true),
])
void main() {
  PokemonRepositoryImpl repository;
  RemotePokemonDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemotePokemonDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PokemonRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getPokemonList', () {
    final tPokemonList = PokemonModel(
      name: "Bulbasaur",
      id: "#001",
      imageUrl:
          "https://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png",
      description:
          "Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun's rays, the seed grows progressively larger.",
      height: "2' 04\"",
      category: "Seed",
      weight: "15.2 lbs",
      types: ["Grass", "Poison"],
      weaknesses: ["Fire", "Flying", "Ice", "Psychic"],
      evolutions: ["#001", "#002", "#003"],
      abilities: ["Overgrow"],
      hp: 20,
      attack: 30,
      defense: 20,
      specialAttack: 30,
      specialDefense: 30,
      speed: 30,
      total: 160,
      malePercentage: "87.5%",
      femalePercentage: "12.5%",
      cycles: "20 ",
      eggGroups: "Grass, Monster ",
      evolvedFrom: "",
      baseExp: "64",
      evolveLevel: '',
    ).toJson().toString();
    final List<PokemonEntity> tPokemons = jsonDecode(tPokemonList);
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.getPokemonList();
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getPokemonList())
            .thenAnswer((_) async => tPokemonList);
        //act
        final result = await repository.getPokemonList();
        //assert
        verify(mockRemoteDataSource.getPokemonList());
        expect(result, equals(Right(tPokemons)));
      });
      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getPokemonList())
            .thenAnswer((_) async => tPokemonList);
        //act
        await repository.getPokemonList();
        //assert
        verify(mockRemoteDataSource.getPokemonList());
        verify(mockLocalDataSource.setPokemonList(tPokemonList));
      });
      test(
          'should return server failure when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.getPokemonList())
            .thenThrow(ServerException());
        //act
        final result = await repository.getPokemonList();
        //assert
        verify(mockRemoteDataSource.getPokemonList());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        //arrange
        when(mockLocalDataSource.getPokemonList())
            .thenAnswer((_) async => tPokemons);
        //act
        final result = await repository.getPokemonList();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getPokemonList());
        expect(result, equals(Right(tPokemons)));
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        //arrange
        when(mockLocalDataSource.getPokemonList()).thenThrow(CacheException());
        //act
        final result = await repository.getPokemonList();
        //assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getPokemonList());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
