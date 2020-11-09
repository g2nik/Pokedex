import 'package:flutter/material.dart';
import 'package:pokedex/src/widgets/poke_swiper.dart';
import '../../src/providers/poke_provider.dart';
import '../../src/search/search_delegate.dart';

class HomePage extends StatelessWidget {
  final pokeProvider = new PokeProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Pokédex'),
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: DataSearch(),
              );
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
          ],
        ),
      )
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: pokeProvider.getPokemons(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        return snapshot.hasData
        ? PokeSwiper(pokemons: snapshot.data)
        : Container(
            height: 400.0,
            child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)))
          );
        }
    );
  }
}