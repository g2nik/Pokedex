
import 'package:flutter/material.dart';
import 'package:pokedex/src/models/poke_model.dart';

class PokeStats extends StatelessWidget {
  final Pokemon pokemon;
  PokeStats(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              PokeTextCard("HP: ${pokemon.hp}"),
              PokeTextCard("Att: ${pokemon.attack}"),
              PokeTextCard("Def: ${pokemon.defense}"),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              PokeTextCard("S. Att: ${pokemon.specialAttack}"),
              PokeTextCard("S. Def: ${pokemon.specialDefense}"),
              PokeTextCard("Speed: ${pokemon.speed}"),
            ],
          ),
        ],
      )
    );
  }
}

class PokeTextCard extends StatelessWidget {
  double size = 15;
  final String stat;
  PokeTextCard(this.stat, [this.size]);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(stat, style: TextStyle(fontSize: size, color: Colors.white)),
      ),
    );
  }
}