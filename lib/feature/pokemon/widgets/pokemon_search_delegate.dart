import 'package:flutter/material.dart';
import 'package:pokedexapp/feature/pokemon/controller/pokemon_provider.dart';
import 'package:pokedexapp/feature/pokemon/screens/pokemon_detail_screen.dart';
import 'package:provider/provider.dart';

class PokemonSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    ThemeData themeData = Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        elevation: 0,
        toolbarTextStyle: TextStyle(
          color: Colors.white
        )
      ),

    );
    return themeData;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Center(child: Text('Search through the PokeDex'))
        : Consumer<PokemonProvider>(
            builder: (ctx, data, child) {
              final searchResults = data.getSearchResults(query);
              return searchResults.isEmpty
                  ? Center(
                      child: Text('The pokemon with \'$query\' doesnt exist'),
                    )
                  : ListView.separated(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      itemCount: searchResults.length,
                      itemBuilder: (ctx, index) {
                        final pokemon = searchResults[index];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PokemonDetailScreen(
                                      id: pokemon.id,
                                    )));
                          },
                          leading: Image.network(
                            pokemon.imageUrl,
                            height: 80,
                          ),
                          title: Text(pokemon.name),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Center(child: Text('Search through the PokeDex'))
        : Consumer<PokemonProvider>(
            builder: (ctx, data, child) {
              final searchResults = data.getSearchResults(query);
              return searchResults.isEmpty
                  ? Center(
                      child: Text('The pokemon with \'$query\' doesnt exist'),
                    )
                  : ListView.separated(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                      itemCount: searchResults.length,
                      itemBuilder: (ctx, index) {
                        final pokemon = searchResults[index];
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PokemonDetailScreen(
                                      id: pokemon.id,
                                    )));
                          },
                          leading: Image.network(
                            pokemon.imageUrl,
                            height: 80,
                          ),
                          title: Text(pokemon.name),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    );
            },
          );
  }
}
