import 'package:pokedexapp/model/pokemon_model.dart';

/// This class is used to cache our local data source when we do not
/// have connectivity
abstract class PokemonLocalDataSource {
  /// Gets the cached [PokemonModel] which was gotten the last time
  /// the user had connection
  ///
  /// Throws [NoLocalDataException] if no cached data is present.

  Future<void> getCachePokemonList(List<PokemonModel> pokemonModel);
}