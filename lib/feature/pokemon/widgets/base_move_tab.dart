import 'package:flutter/material.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';

import '../../../core/utilities/pokemon_utlis.dart';

class BaseMoveTab extends StatelessWidget {
  final PokemonModel pokemon;
  const BaseMoveTab({Key key, this.pokemon}) : super(key: key);

  Widget _buildItem(String title, int value) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.grey.shade700),
            )),
        SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 1,
            child: Text(
              '$value',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            )),
        Expanded(
            flex: 2,
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: PokemonUtils.getColor(pokemon).withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                PokemonUtils.getColor(pokemon),
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildItem('HP', pokemon.hp),
        SizedBox(
          height: 15,
        ),
        _buildItem('Attack', pokemon.attack),
        SizedBox(
          height: 15,
        ),
        _buildItem('Speed', pokemon.speed),
        SizedBox(
          height: 15,
        ),
        _buildItem('Defense', pokemon.defense),
        SizedBox(
          height: 15,
        ),
        _buildItem('Sp. Attack', pokemon.specialAttack),
        SizedBox(
          height: 15,
        ),
        _buildItem('Sp. Defense', pokemon.specialDefense),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
