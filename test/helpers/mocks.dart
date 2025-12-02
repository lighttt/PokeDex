import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedexapp/core/network/network_info.dart';
import 'package:pokedexapp/data/datasources/pokemon_local_datasource.dart';
import 'package:pokedexapp/data/datasources/pokemon_remote_datasource.dart';
import 'package:pokedexapp/domain/repositories/pokemon_repository.dart';

class MockConnectivity extends Mock implements Connectivity {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockRemoteDataSource extends Mock implements RemotePokemonDataSource {}

class MockLocalDataSource extends Mock implements LocalPokemonDataSource {}

class MockPokemonRepository extends Mock implements PokemonRepository {}
