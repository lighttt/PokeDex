import 'package:dartz/dartz.dart';
import 'package:pokedexapp/core/error/failures.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';

abstract class PokemonRepository{
  Future<Either<Failure, List<PokemonModel>>> getPokemonList();
}