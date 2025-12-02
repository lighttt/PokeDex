import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:pokedexapp/core/network/network_info.dart';
import 'package:pokedexapp/core/services/service_locator.dart';
import 'package:pokedexapp/feature/pokemon/controller/pokemon_controller.dart';
import 'package:pokedexapp/feature/pokemon/screens/favourite_screen.dart';
import 'package:pokedexapp/feature/pokemon/widgets/pokemon_list_item.dart';
import 'package:pokedexapp/feature/pokemon/widgets/pokemon_search_delegate.dart';
import 'package:provider/provider.dart';

class PokemonListScreen extends StatefulWidget {
  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  late Future<void> _fetchData;

  Future<void> _getPokemonData() async {
    try {
      await Provider.of<PokemonProvider>(context, listen: false).getPokemonData();
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
        title: Text(
          'PokeDex',
          style: TextStyle(fontSize: 28),
        ),
        elevation: 0,
        centerTitle: false,
        actions: [
          StreamBuilder<ConnectivityResult>(
              stream: locator<NetworkInfo>().connectionStream,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                }
                final connected = snapshot.data != ConnectivityResult.none;
                return Icon(
                  connected ? Icons.wifi : Icons.signal_wifi_bad_outlined,
                  size: 30,
                  color: connected ? Colors.green : Colors.red.shade700,
                );
              }),
          SizedBox(width: 10),
          IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.search, size: 30),
              onPressed: () {
                showSearch(context: context, delegate: PokemonSearchDelegate());
              }),
          IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.favorite_border, size: 30),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const FavouriteScreen()));
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
            return const Center(child: Text('Sorry data could not be loaded'));
          }
          return Consumer<PokemonProvider>(
            builder: (ctx, data, child) {
              final pokemonList = data.pokemonList;
              if (pokemonList.isEmpty) {
                return const Center(child: Text('No Pokemon found'));
              }
              return RefreshIndicator(
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  onRefresh: () async {
                    setState(() {
                      _fetchData = _getPokemonData();
                    });
                    await _fetchData;
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                    itemCount: pokemonList.length,
                    itemBuilder: (ctx, index) {
                      final pokemon = pokemonList[index];
                      return PokemonListItem(
                        pokemon: pokemon,
                      );
                    },
                  ));
            },
          );
        },
      ),
    );
  }
}
