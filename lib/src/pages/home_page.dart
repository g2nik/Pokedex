import 'package:flutter/material.dart';
import 'package:pokedex/src/widgets/poke_swiper.dart';
import '../../src/providers/poke_provider.dart';
import '../../src/search/search_delegate.dart';

class HomePage extends StatelessWidget {
  final pokeProvider = new PokeProvider();

  //The home page now only uses the cardSwiper widget
  //The _footer widget has been removed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //The AppBar is now red
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
        //The background is now an image
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiper(),
          ],
        ),
      )
    );
  }

  //Now the widget uses a pokeswiper widget, which is the modified version of the card swiper
  Widget _swiper() {
    return FutureBuilder(
      future: pokeProvider.getPokemons(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        return snapshot.hasData
        ? PokeSwiper(pokemons: snapshot.data)
        : Container(
            height: 400.0,
            //The loading circle is red
            child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)))
          );
        }
    );
  }
}