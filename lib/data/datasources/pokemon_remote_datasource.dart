import 'package:flutter/material.dart';
import 'package:pokedexapp/core/error/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class RemotePokemonDataSource {
  Future<String> getPokemonList();
}

class RemotePokemonDataSourceImpl implements RemotePokemonDataSource {

 final http.Client httpClient;

 RemotePokemonDataSourceImpl({@required this.httpClient});

  @override
  Future<String> getPokemonList() async {
    try {
      final response = await httpClient.get(Uri.parse(
          'https://gist.githubusercontent.com/lighttt/20e03ef249cc9b3ab5496b777c6f066f/raw/b27d2dce021d3b1f906f47bdbf574ffba62c1ded/pokeapi.json'));
      return response.body;
    } catch (error) {
      throw ServerException();
    }
  }
}
