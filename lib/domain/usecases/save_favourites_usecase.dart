import 'package:dartz/dartz.dart';
import 'package:pokedexapp/core/error/failures.dart';
import 'package:pokedexapp/core/usecases/usecase.dart';
import 'package:pokedexapp/domain/repositories/pokemon_repository.dart';

class SaveFavouriteIdsUseCase implements UseCase<void, SaveFavouriteIdsParams> {
  final PokemonRepository repository;

  SaveFavouriteIdsUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(SaveFavouriteIdsParams params) {
    return repository.saveFavouriteIds(params.ids);
  }
}

class SaveFavouriteIdsParams {
  final List<String> ids;
  SaveFavouriteIdsParams(this.ids);
}
