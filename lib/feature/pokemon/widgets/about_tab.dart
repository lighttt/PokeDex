import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedexapp/data/models/pokemon_model.dart';

class AboutTab extends StatelessWidget {
  final PokemonModel pokemon;
  const AboutTab({Key key, this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          pokemon.description,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        SizedBox(
          height: 20,
        ),
        Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Height',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      pokemon.height,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Weight',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      pokemon.weight,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Text(
              'Gender',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 50),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.mars,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text(
                  pokemon.malePercentage,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.venus, color: Colors.pink),
                SizedBox(width: 10),
                Text(
                  pokemon.femalePercentage,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
