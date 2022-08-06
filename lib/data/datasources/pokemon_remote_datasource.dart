import 'package:pokedexapp/model/pokemon_model.dart';

/// The data source is actually where the data is got from the API
/// Here we create http methods we want without returning Failure types
/// instead we throw normal exceptions
abstract class PokemonRemoteDataSource {

  /// Calls the http://numbersapi.com/random endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> getCachePokemonList(List<PokemonModel> pokemonModel);
}