import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../models/poke_model.dart';
import 'poke_type.dart';

class PokeSwiper extends StatefulWidget {
  final List<Pokemon> pokemons;
  
  PokeSwiper({ @required this.pokemons });

  @override
  _PokeSwiperState createState() => _PokeSwiperState();
}

class _PokeSwiperState extends State<PokeSwiper> {
  int keyIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      
    )

    return widget.pokemons[keyIndex].loaded
    ? Container(
       padding: EdgeInsets.only(top: 10.0),
       child: Column(
         children: <Widget>[
           Swiper(
              layout: SwiperLayout.STACK,
              itemWidth: _screenSize.width * .7,
              itemHeight: _screenSize.height * .5,
              itemCount: widget.pokemons.length,
              itemBuilder: (BuildContext context, int index) {
                return Hero(
                  tag: widget.pokemons[index].id.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'detalle', arguments: widget.pokemons[index]);
                        print(widget.pokemons[index].id);
                        print(index);
                      },
                      child: FadeInImage(
                        image: NetworkImage(widget.pokemons[index].imageUrl),
                        placeholder: AssetImage('assets/pokeball.png'),
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                );
              },
              onIndexChanged: (index) {
                setState(() => keyIndex = index);
              },
            ),
            SizedBox(height: 50),
            Text(widget.pokemons[keyIndex].name),
            pokeType(),
         ],
       ),
    )
    : Center(child: CircularProgressIndicator());
  }

  Widget pokeType() {
    return widget.pokemons[keyIndex].numberTypes == 1//widget.pokemons[keyIndex].types.length == 1
    ? PokeType((widget.pokemons[keyIndex].firstType))
    : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        PokeType((widget.pokemons[keyIndex].firstType)),
        SizedBox(width: 50),
        PokeType((widget.pokemons[keyIndex].secondType))
      ],
    );
  }
}


