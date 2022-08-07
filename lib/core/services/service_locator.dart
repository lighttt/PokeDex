import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart';
import 'package:pokedexapp/core/network/network_info.dart';
import 'package:pokedexapp/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedexapp/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedexapp/data/repositories/pokemon_repository_impl.dart';
import 'package:pokedexapp/domain/repositories/pokemon_repository.dart';
import 'package:pokedexapp/domain/usecases/get_pokemons_usecase.dart';
import 'package:pokedexapp/feature/pokemon/controller/pokemon_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// service locator
final locator = GetIt.instance;

Future<void> init() async {
  //! Features
  locator.registerFactory(() => PokemonProvider(
      getPokemonListUseCase: locator()));

  // Use cases
  locator.registerLazySingleton(() => GetPokemonListUseCase(repository: locator()));

  // Repository
  locator.registerLazySingleton<PokemonRepository>(
          () => PokemonRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkInfo: locator(),
      ));
  // Data sources
  locator.registerLazySingleton<RemotePokemonDataSource>(
          () => RemotePokemonDataSourceImpl(httpClient: locator()));

  locator.registerLazySingleton<LocalPokemonDataSource>(
          () => LocalPokemonDataSourceImpl(sharedPreferences: locator()));

  //! Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}