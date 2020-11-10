import 'package:flutter/material.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/widgets/poke_type.dart';
import 'package:pokedex/src/widgets/poke_card.dart';

class PokeDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //I now display the pokemon image, its name on the appBar, its description, types and evolution/s
    final Pokemon pokemon = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(pokemon.name),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(pokemon.imageUrl ?? "", width: 300),
            _description(pokemon.description),
            SizedBox(height: 30.0),
            PokeTypes(pokemon),
            SizedBox(height: 40.0),
            _evolutions( pokemon )
          ]
        ),
      ),
    );
  }

  Widget _description(String descripcion ) {
    return Text(
      descripcion,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.redAccent,
        fontSize: 15
      ),
    );
  }

  //In case the pokemon has only 1 evolution i show nothing, in case it has 2 or 3 i show them in a row
  Widget _evolutions(Pokemon pokemon) {
    if (pokemon.evolutions == 1) {
      return Container();
    } else if (pokemon.evolutions == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              Image.network(pokemon.firstEvolutionImageUrl ?? "", width: 175),
              PokeTextCard(pokemon.firstEvolutionName.toUpperCase()),
            ],
          ),
          Column(
            children: [
              Image.network(pokemon.secondEvolutionImageUrl ?? "", width: 175),
              PokeTextCard(pokemon.secondEvolutionName.toUpperCase()),
            ],
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              Image.network(pokemon.firstEvolutionImageUrl ?? "", width: 125),
              PokeTextCard(pokemon.firstEvolutionName.toUpperCase(), 12),
            ],
          ),
          Column(
            children: [
              Image.network(pokemon.secondEvolutionImageUrl ?? "", width: 125),
              PokeTextCard(pokemon.secondEvolutionName.toUpperCase(), 12),
            ],
          ),
          Column(
            children: [
              Image.network(pokemon.thirdEvolutionImageUrl ?? "", width: 125),
              PokeTextCard(pokemon.thirdEvolutionName.toUpperCase(), 12),
            ],
          ),
          
        ],
      );
    }
  }
}
