import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:pokedexapp/core/error/exceptions.dart';
import 'package:pokedexapp/core/error/failures.dart';
import 'package:pokedexapp/core/network/network_info.dart';
import 'package:pokedexapp/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedexapp/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedexapp/data/dtos/pokemon_dto.dart';
import 'package:pokedexapp/domain/entities/pokemon_entity.dart';
import 'package:pokedexapp/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final RemotePokemonDataSource remoteDataSource;
  final LocalPokemonDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UnmodifiableListView<PokemonEntity>>> getPokemonList() async {
    //check if there is network
    if (await networkInfo.isConnected) {
      try {
        final remotePokemonList = await remoteDataSource.getPokemonList();
        localDataSource.setPokemonList(remotePokemonList);
        final favouriteIds = await localDataSource.getFavouriteIds();
        List<dynamic> responseList = jsonDecode(remotePokemonList);
        final pokemonList = List<PokemonDTO>.from(
          responseList.map((pokemon) => PokemonDTO.fromJson(pokemon)),
        ).map(
          (dto) => dto.toEntity(isFavourite: favouriteIds.contains(dto.id)),
        );
        return Right(UnmodifiableListView<PokemonEntity>(pokemonList.toList()));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    //try loading cache data when no network
    else {
      try {
        final localPokemonList = await localDataSource.getPokemonList();
        final favouriteIds = await localDataSource.getFavouriteIds();
        final entities = localPokemonList.map((dto) => dto.toEntity(isFavourite: favouriteIds.contains(dto.id))).toList();
        return Right(UnmodifiableListView(entities));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> saveFavouriteIds(List<String> ids) async {
    try {
      await localDataSource.saveFavouriteIds(ids);
      return const Right(null);
    } catch (_) {
      return Left(CacheFailure());
    }
  }
}
