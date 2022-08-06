import 'package:flutter/material.dart';
import 'package:pokedexapp/providers/pokemon_provider.dart';
import 'package:pokedexapp/screens/tabs/about_tab.dart';
import 'package:pokedexapp/screens/tabs/evolution_tab.dart';
import 'package:provider/provider.dart';

import '../pokemon_utlis.dart';
import 'tabs/base_move_tab.dart';

class PokemonDetailScreen extends StatelessWidget {
  final String id;

  const PokemonDetailScreen({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPokemon =
        Provider.of<PokemonProvider>(context, listen: false).getPokemonById(id);
    return Scaffold(
      backgroundColor: PokemonUtils.getColor(selectedPokemon),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PokemonUtils.getColor(selectedPokemon),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Consumer<PokemonProvider>(
            builder: (BuildContext context, data, Widget child) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                    selectedPokemon.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: selectedPokemon.isFavourite
                        ? Colors.red.shade200
                        : Colors.white,
                  ),
                  iconSize: 28,
                  onPressed: () {
                    data.toggleFavourite(selectedPokemon.id);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        selectedPokemon.name,
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        selectedPokemon.id,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: selectedPokemon.types
                        .map((type) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              decoration: BoxDecoration(
                                  color: PokemonUtils.getColorType(type),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white)),
                              child: Text(type,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            Hero(
              tag: 'pokemon${selectedPokemon.id}',
              child: Image.network(
                selectedPokemon.imageUrl,
                height: 200,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: TabBar(
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey.shade700,
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                tabs: [
                  Tab(
                    text: 'About',
                  ),
                  Tab(
                    text: 'Evolutions',
                  ),
                  Tab(
                    text: 'Base Moves',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: AboutTab(
                        pokemon: selectedPokemon,
                      ),
                    ),
                    SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: EvolutionTab(
                          pokemonModel: selectedPokemon,
                        )),
                    SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: BaseMoveTab(
                          pokemon: selectedPokemon,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
