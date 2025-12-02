import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedexapp/core/error/exceptions.dart';
import 'package:pokedexapp/core/error/failures.dart';
import 'package:pokedexapp/core/network/network_info.dart';
import 'package:pokedexapp/data/dtos/pokemon_dto.dart';
import 'package:pokedexapp/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedexapp/domain/entities/pokemon_entity.dart';

import '../../helpers/fixture_reader.dart';
import '../../helpers/mocks.dart';

void main() {
  late PokemonRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PokemonRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final List<PokemonDTO> dtoList = (jsonDecode(fixture('pokemon.json')) as List)
      .map((e) => PokemonDTO.fromJson(e as Map<String, dynamic>))
      .toList();

  group('getPokemonList', () {
    test('should fetch from remote when online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getPokemonList())
          .thenAnswer((_) async => fixture('pokemon.json'));
      when(() => mockLocalDataSource.setPokemonList(any())).thenAnswer((_) async => {});
      when(() => mockLocalDataSource.getFavouriteIds()).thenAnswer((_) async => ['#001']);
      // act
      final result = await repository.getPokemonList();
      // assert
      expect(result, isA<Right<Failure, UnmodifiableListView<PokemonEntity>>>());
      final list = result.getOrElse(() => UnmodifiableListView([]));
      expect(list.first.isFavourite, isTrue);
      verify(() => mockRemoteDataSource.getPokemonList()).called(1);
      verify(() => mockLocalDataSource.setPokemonList(any())).called(1);
    });

    test('should return cache when offline', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocalDataSource.getPokemonList())
          .thenAnswer((_) async => UnmodifiableListView(dtoList));
      when(() => mockLocalDataSource.getFavouriteIds()).thenAnswer((_) async => []);
      // act
      final result = await repository.getPokemonList();
      // assert
      expect(result, isA<Right<Failure, UnmodifiableListView<PokemonEntity>>>());
      verifyNever(() => mockRemoteDataSource.getPokemonList());
    });

    test('should return failure when cache missing offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocalDataSource.getPokemonList()).thenThrow(CacheException());
      final result = await repository.getPokemonList();
      expect(result, equals(Left(CacheFailure(message: 'Cache Failure'))));
    });
  });

  group('saveFavouriteIds', () {
    test('should call local data source', () async {
      when(() => mockLocalDataSource.saveFavouriteIds(any())).thenAnswer((_) async => {});
      final result = await repository.saveFavouriteIds(['#001']);
      expect(result, const Right(null));
      verify(() => mockLocalDataSource.saveFavouriteIds(['#001'])).called(1);
    });

    test('should return failure on exception', () async {
      when(() => mockLocalDataSource.saveFavouriteIds(any())).thenThrow(Exception());
      final result = await repository.saveFavouriteIds(['#001']);
      expect(result, isA<Left<Failure, void>>());
    });
  });
}
