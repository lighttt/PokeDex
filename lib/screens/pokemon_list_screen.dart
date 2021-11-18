import 'package:flutter/material.dart';
import 'package:pokedexapp/providers/pokemon_provider.dart';
import 'package:pokedexapp/screens/favourite_screen.dart';
import 'package:pokedexapp/screens/pokemon_list_item.dart';
import 'package:pokedexapp/screens/pokemon_search_delegate.dart';
import 'package:provider/provider.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({Key key}) : super(key: key);

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  bool _isInit = true;
  Future _fetchData;

  Future<void> _getPokemonData() async {
    try {
      await Provider.of<PokemonProvider>(context, listen: false)
          .getPokemonData();
    } catch (error) {
      print(error);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _fetchData = _getPokemonData();
    }
    _isInit = false;
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
              onPressed: () {
                showSearch(context: context, delegate: PokemonSearchDelegate());
              }),
          IconButton(
              icon: Icon(Icons.favorite_border, size: 30),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => FavouriteScreen()));
              })
        ],
      ),
      body: FutureBuilder(
        future: _fetchData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : Consumer<PokemonProvider>(
                  builder: (ctx, data, child) {
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemCount: 50,
                      itemBuilder: (ctx, index) {
                        final pokemon = data.pokemonList[index];
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
