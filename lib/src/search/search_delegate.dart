import 'package:flutter/material.dart';
import '../../src/models/poke_model.dart';
import 'package:pokedex/src/providers/poke_provider.dart';

class DataSearch extends SearchDelegate {
  String seleccion = "";
  final pokeProvider = new PokeProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //This function now displays the text below
    return Center(child: Container(child: Text("Type a valid pokemon name")));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder (
      //I ask the provider to search the pokemon using the query as its name
      future: pokeProvider.searchPokemon(query),
      builder: (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
        if (snapshot.hasData) {
          Pokemon pokemon = snapshot.data;
          return Column(
            children: <Widget>[
              ListTile(
                tileColor: Colors.white,
                title: Text(pokemon.name),
                onTap: () {
                  if (pokemon.loaded) Navigator.pushNamed(context, 'detail', arguments: pokemon);
                },
              ),
            ]
          );
        } else return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)));
      },
    );
  }
}
