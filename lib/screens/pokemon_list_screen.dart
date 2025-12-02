import 'package:flutter/material.dart';
import 'package:pokedexapp/providers/pokemon_provider.dart';
import 'package:pokedexapp/screens/favourite_screen.dart';
import 'package:pokedexapp/screens/pokemon_list_item.dart';
import 'package:pokedexapp/screens/pokemon_search_delegate.dart';
import 'package:provider/provider.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({Key? key}) : super(key: key);

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  late final Future<void> _fetchData;

  Future<void> _getPokemonData() async {
    try {
      await Provider.of<PokemonProvider>(context, listen: false)
          .getPokemonData();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData = _getPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PokeDex',
          style: TextStyle(fontSize: 28),
        ),
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                showSearch(context: context, delegate: PokemonSearchDelegate());
              }),
          IconButton(
              icon: const Icon(Icons.favorite_border, size: 30),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const FavouriteScreen()));
              })
        ],
      ),
      body: FutureBuilder<void>(
        future: _fetchData,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load Pokemon',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            );
          }
          return Consumer<PokemonProvider>(
            builder: (ctx, data, child) {
              final pokemonList = data.pokemonList;
              if (pokemonList.isEmpty) {
                return const Center(child: Text('No Pokemon found'));
              }
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: pokemonList.length,
                itemBuilder: (ctx, index) {
                  final pokemon = pokemonList[index];
                  return PokemonListItem(
                    pokemon: pokemon,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
