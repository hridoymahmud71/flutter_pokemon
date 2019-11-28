import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//own
import 'package:flutter_pokemon/config/poke_config.dart';
import 'package:flutter_pokemon/models/pokemon.dart';

class Detail extends StatefulWidget {
  Pokemon pokemon;

  Detail(Pokemon pokemon) {
    this.pokemon = pokemon;
  }

  @override
  _DetailState createState() => _DetailState(pokemon);
}

class _DetailState extends State<Detail> {
  Pokemon pokemon;

  _DetailState(Pokemon pokemon) {
    this.pokemon = pokemon;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      this.pokemon.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return this.pokemon == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: Text(this.pokemon.name),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: bodyWidget(context),
          );
  }

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width / 1.5,
            left: MediaQuery.of(context).size.width * .16,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    Center(
                      child: Text(this.pokemon.name,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Text("Height:${this.pokemon.height}"),
                          Text("Weight:${this.pokemon.weight}"),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Text("Types"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: pokemon.types
                                .map((t) => FilterChip(
                                    backgroundColor: Colors.redAccent,
                                    label: Text(t.type.name),
                                    onSelected: (b) {},
                                    elevation: 2.0))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Text("Abilities"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: pokemon.abilities
                                .map((a) => FilterChip(
                                    backgroundColor: Colors.amber,
                                    label: Text(a.ability.name),
                                    onSelected: (b) {},
                                    elevation: 2.0))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Text("Moves"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: pokemon.moves
                                .map((m) => FilterChip(
                                    backgroundColor: Colors.lightBlue,
                                    label: Text(m.move.name),
                                    onSelected: (b) {},
                                    elevation: 2.0))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: this.pokemon.sprites.frontShiny == null
                ? Center(child: CircularProgressIndicator())
                : Hero(
                    tag: this.pokemon.sprites.frontShiny,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                this.pokemon.sprites.frontShiny,
                              ))),
                    ),
                  ),
          ),
        ],
      );
}
