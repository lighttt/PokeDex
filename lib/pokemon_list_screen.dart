import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedexapp/model/pokemon_model.dart';
import 'package:pokedexapp/pokemon_utlis.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({Key key}) : super(key: key);

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  List<PokemonModel> _pokemonList = [];

  Future<void> _getPokemonData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://gist.githubusercontent.com/lighttt/20e03ef249cc9b3ab5496b777c6f066f/raw/b27d2dce021d3b1f906f47bdbf574ffba62c1ded/pokeapi.json'));
      List<dynamic> responseList = jsonDecode(response.body);
      _pokemonList = List<PokemonModel>.from(
          responseList.map((pokemon) => PokemonModel.fromJson(pokemon)));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PokeDex',
          style: TextStyle(fontSize: 28),
        ),
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.favorite_border, size: 30), onPressed: () {})
        ],
      ),
      body: FutureBuilder(
        future: _getPokemonData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: 50,
                  itemBuilder: (ctx, index) {
                    final pokemon = _pokemonList[index];
                    return Card(
                        elevation: 2,
                        color: PokemonUtils.getColor(pokemon),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    pokemon.id,
                                    style: TextStyle(
                                        color: Colors.grey.shade300,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                pokemon.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: pokemon.types
                                          .map((type) => Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 4),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4, horizontal: 4),
                                                decoration: BoxDecoration(
                                                    color:
                                                        PokemonUtils.getColor(
                                                            pokemon),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.white)),
                                                child: Text(type,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12)),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Image.network(
                                      pokemon.imageUrl,
                                      height: 100,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ));
                  },
                );
        },
      ),
    );
  }
}
