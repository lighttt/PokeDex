import 'dart:collection';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:pokedexapp/core/error/exceptions.dart';
import 'package:pokedexapp/core/error/failures.dart';
import 'package:pokedexapp/core/network/network_info.dart';
import 'package:pokedexapp/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedexapp/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';
import 'package:pokedexapp/domain/repositories/pokemon_repository.dart';


class PokemonRepositoryImpl implements PokemonRepository {
  final RemotePokemonDataSource remoteDataSource;
  final LocalPokemonDataSource localDataSource;
  final NetworkInfo networkInfo;

  PokemonRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  /// Function to implement random or concrete
  /// Here we pass our own function to implement
  @override
  Future<Either<Failure, UnmodifiableListView<PokemonModel>>> getPokemonList() async {
    //check if there is network
    if (await networkInfo.isConnected) {
      try {
        final remotePokemonList = await remoteDataSource.getPokemonList();
        localDataSource.setPokemonList(remotePokemonList);
        List<dynamic> responseList = jsonDecode(remotePokemonList);
        List<PokemonModel> _pokemonList = List<PokemonModel>.from(
            responseList.map((pokemon) => PokemonModel.fromJson(pokemon)));
        return Right(UnmodifiableListView(_pokemonList));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    //try loading cache data when no network
    else {
      try {
        final localPokemonList = await localDataSource.getPokemonList();
        return Right(localPokemonList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
