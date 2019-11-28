import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//own
import 'package:flutter_pokemon/config/poke_config.dart';
import 'package:flutter_pokemon/models/pokemon.dart';
import 'package:flutter_pokemon/ui/detail/detail.dart';

class GridItem extends StatefulWidget {
  String url;

  GridItem(url) {
    this.url = url;
  }

  @override
  _GridItemState createState() => _GridItemState(url);
}

class _GridItemState extends State<GridItem> {
  String url;
  Pokemon pokemon;

  String name;
  Image image;
  AssetImage assetImage;

  _GridItemState(url) {
    this.url = url;
  }

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  fetchPokemon() async {
    //print("My url" + this.url);
    var res = await http.get(this.url);
    //print(res.body);
    var decodedJson = jsonDecode(res.body);

    setState(() {
      this.pokemon = Pokemon.fromJson(decodedJson);
      this.name =
          pokemon != null && pokemon.name != null ? pokemon.name : "<Unknown>";
      this.image = pokemon != null && pokemon.sprites.frontDefault != null
          ? Image.network(pokemon.sprites.frontDefault, fit: BoxFit.contain)
          : Image.network(PokeConfig.placeholderUrl(PokeConfig.imageWidth),
              fit: BoxFit.contain);
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.pokemon == null
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                navigateToDetail(this.pokemon);
              },
              child: Card(
                elevation: 5.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: this.image,
                    ),
                    Text(
                      name,
                    )
                  ],
                ),
              ),
            ),
          );
  }

  void navigateToDetail(Pokemon pokemon) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Detail(pokemon)));
  }
}
