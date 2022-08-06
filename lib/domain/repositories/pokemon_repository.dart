import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:pokedexapp/core/error/failures.dart';
import 'package:pokedexapp/domain/entities/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<Either<Failure, UnmodifiableListView<PokemonEntity>>> getPokemonList();
}
