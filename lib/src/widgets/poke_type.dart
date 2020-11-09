import 'package:flutter/material.dart';
import 'package:pokedex/src/models/poke_model.dart';

class PokeTypes extends StatelessWidget {

  final Pokemon pokemon;
  PokeTypes(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return pokemon.numberTypes == 1
    ? ToolTip(pokemon.firstType)
    : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ToolTip(pokemon.firstType),
        SizedBox(width: 50),
        ToolTip(pokemon.secondType)
      ],
    );
  }
}

class ToolTip extends StatelessWidget {
  ToolTip(type) {
    this.type = type;

    switch (type) {
      case "normal": themeColor = Color(0xff9099a1); break;
      case "fire": themeColor = Color(0xffff9c54); break;
      case "fighting": themeColor = Color(0xffc03028); break;
      case "water": themeColor = Color(0xff4d90d5); break;
      case "flying": themeColor = Color(0xff8fa8dd);break;
      case "grass": themeColor = Color(0xff63bb5b); break;
      case "poison": themeColor = Color(0xffab6ac8); break;
      case "electric": themeColor = Color(0xfff8d030); break;
      case "ground": themeColor = Color(0xffd97746); break;
      case "psychic": themeColor = Color(0xfff97176); break;
      case "rock": themeColor = Color(0xffc7b78b); break;
      case "ice": themeColor = Color(0xff74cec0); break;
      case "bug": themeColor = Color(0xff90c12c); break;
      case "dragon": themeColor = Color(0xff0a6dc4); break;
      case "ghost": themeColor = Color(0xff5269ac); break;
      case "dark": themeColor = Color(0xff5a5366); break;
      case "steel": themeColor = Color(0xff5a8ea1); break;
      case "fairy": themeColor = Color(0xffec8fe6); break;
      case "unknown": themeColor = Color(0xff68a090); break;
      default: themeColor = Colors.redAccent; break;
    }
  }

  String type;
  Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Tooltip (
      verticalOffset: 40,
      message: type.toUpperCase(),
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      child: Container(width: 75, child: Image.asset("assets/types/$type.png")),
      decoration: BoxDecoration(
        color: themeColor,
        borderRadius: BorderRadius.all(Radius.circular(25))
      ),
    );
  }
}
