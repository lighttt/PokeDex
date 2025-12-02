import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:pokedexapp/domain/entities/pokemon_entity.dart';
import 'package:pokedexapp/domain/repositories/pokemon_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/failures.dart';

class GetPokemonListUseCase implements UseCase<UnmodifiableListView<PokemonEntity>, NoParams> {
  final PokemonRepository repository;

  GetPokemonListUseCase({required this.repository});

  /// The return value may either be failure or value: as Either<L,R>
  /// The call methods helps to directly call a class function
  /// rather than pointing to specific part
  @override
  Future<Either<Failure, UnmodifiableListView<PokemonEntity>>> call(NoParams noParams) async {
    return await repository.getPokemonList();
  }
}
