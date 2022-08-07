import 'package:flutter/material.dart';
import 'package:pokedexapp/feature/pokemon/controller/pokemon_provider.dart';
import 'package:pokedexapp/feature/pokemon/widgets/pokemon_list_item.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Favourites'),
        elevation: 0,
      ),
      body: Consumer<PokemonProvider>(
        builder: (ctx, data, child) {
          final favourites = data.getFavourites();
          return favourites.isEmpty
              ? Center(child: Text('No favourites have been added'))
              : GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: favourites.length,
                  itemBuilder: (ctx, index) {
                    final pokemon = favourites[index];
                    return PokemonListItem(
                      pokemon: pokemon,
                    );
                  },
                );
        },
      ),
    );
  }
}
