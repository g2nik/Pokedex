import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Pokemon {
  String name;
  int id;

  List<dynamic> types;
  String firstType;
  String secondType;

  int hp;
  int attack;
  int defense;
  int specialAttack;
  int specialDefense;
  int speed;

  String speciesUrl;

  String technicalName;
  String imageUrl;

  int rating = 5;
  bool correct = true;
  bool loaded = false;

  int evolutions;
  String firstEvolutionName;
  String secondEvolutionName;
  String thirdEvolutionName;
  String firstEvolutionImageUrl = "N/A";
  String secondEvolutionImageUrl = "N/A";
  String thirdEvolutionImageUrl = "N/A";

  Pokemon(Map<String, dynamic> json) {
    id = json["id"];
    name = capitalize(shorten(json["name"]));
    
    types = json["types"];
    firstType = types[0]["type"]["name"];
    secondType = types.length == 2 ? types[1]["type"]["name"] : "N/A";

    hp = json["stats"][0]["base_stat"];
    attack = json["stats"][1]["base_stat"];
    defense = json["stats"][2]["base_stat"];
    specialAttack = json["stats"][3]["base_stat"];
    specialDefense = json["stats"][4]["base_stat"];
    speed = json["stats"][5]["base_stat"];

    speciesUrl = json["species"]["url"];
    imageUrl = getImage(id);
  }

  String capitalize(String name) {
    return name[0].toUpperCase() + name.substring(1);
  }

  String shorten(String name) {
    bool exit = false;
    if (name != "ho-oh" && name != "porygon-z" && name != "jangmo-o" && name != "hakamo-o" && name != "kommo-o") {
      for (int i = 0; i < name.length && !exit; i++) {
        if (name[i] == "-") {
          exit = true;
          name = name.substring(0, i);
        }
      }
    }
    return name;    
  }

  String getImage(int pokeId) {
    String imageId = "";
    if (pokeId < 10) imageId = "00$pokeId";
    else if (pokeId < 100) imageId = "0$pokeId";
    else imageId = "$pokeId";
    return "https://assets.pokemon.com/assets/cms2/img/pokedex/full/$imageId.png";
  }

  Future getEvolutionChain() async {
    final speciesResponse = await http.get(speciesUrl);
    String evolutionChain = json.decode(speciesResponse.body)["evolution_chain"]["url"];
    final evolutionResponse = await http.get(evolutionChain);

    var evolution1 = json.decode(evolutionResponse.body)["chain"];
    List<dynamic> evolution2 = evolution1["evolves_to"];
    
    bool second = evolution2.toString().length > 2;
    bool third = false;

    if (second) {
      List<dynamic> evolution3 = evolution1["evolves_to"][0]["evolves_to"];
      third = evolution3.toString().length > 2;
    }
       
    if (!second) evolutions = 1;
    else if (!third) evolutions = 2;
    else evolutions = 3;

    firstEvolutionName = evolution1["species"]["name"];
    secondEvolutionName = second ? evolution2[0]["species"]["name"] : "N/A";
    thirdEvolutionName = third ? evolution2[0]["evolves_to"][0]["species"]["name"] : "N/A";

    if (firstEvolutionName == name.toLowerCase()) firstEvolutionImageUrl = imageUrl;
    if (secondEvolutionName == name.toLowerCase()) secondEvolutionImageUrl = imageUrl;
    if (thirdEvolutionName == name.toLowerCase()) thirdEvolutionImageUrl = imageUrl;
    
    if (firstEvolutionImageUrl == "N/A") {
      final firstResponse = await http.get("https://pokeapi.co/api/v2/pokemon/$firstEvolutionName");
      int firstId = await json.decode(firstResponse.body)["id"];
      firstEvolutionImageUrl = getImage(firstId);
    }

    if (secondEvolutionImageUrl == "N/A" && evolutions > 1) {
      final secondResponse = await http.get("https://pokeapi.co/api/v2/pokemon/$secondEvolutionName");
      int secondId = await json.decode(secondResponse.body)["id"];
      secondEvolutionImageUrl = getImage(secondId);
    }

    if (thirdEvolutionImageUrl == "N/A" && evolutions > 2) {
      final thirdResponse = await http.get("https://pokeapi.co/api/v2/pokemon/$thirdEvolutionName");
      int thirdId = await json.decode(thirdResponse.body)["id"];
      thirdEvolutionImageUrl = getImage(thirdId);
    }
    return;
  }
}