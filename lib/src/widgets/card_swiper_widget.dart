import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../src/models/poke_model.dart';
import 'poke_type.dart';

class CardSwiper extends StatefulWidget {
  final List<Pokemon> pokemons;
  
  CardSwiper({ @required this.pokemons });

  @override
  _CardSwiperState createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  int keyIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

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
         ],
       ),
    )
    : Center(child: CircularProgressIndicator());
  }
}


