import 'package:flutter/material.dart';

//This widget displays white text inside a red card
class PokeTextCard extends StatelessWidget {
  double size = 15;
  final String text;
  //You can specify a size for the card
  PokeTextCard(this.text, [this.size]);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: TextStyle(fontSize: size, color: Colors.white)),
      ),
    );
  }
}