 
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(PokemonCardViewer());
}

class PokemonCardViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Card Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonCardList(),
    );
  }
}

class PokemonCardList extends StatefulWidget {
  @override
  _PokemonCardListState createState() => _PokemonCardListState();
}

class _PokemonCardListState extends State<PokemonCardList> {
  late Future<List<PokemonCard>> _cards;

  @override
  void initState() {
    super.initState();
    _cards = fetchPokemonCards();
  }

  Future<List<PokemonCard>> fetchPokemonCards() async {
    final response = await http.get(Uri.parse('https://api.pokemontcg.io/v2/cards'));
    
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((card) => PokemonCard.fromJson(card)).toList();
    } else {
      throw Exception('Failed to load Pokémon cards');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon Card Viewer'),
      ),
      body: FutureBuilder<List<PokemonCard>>(
        future: _cards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Pokémon cards available.'));
          } else {
            List<PokemonCard> cards = snapshot.data!;
            return ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: cards[index].imageUrl,
                      width: 50,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                    title: Text(cards[index].name),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: CachedNetworkImage(
                              imageUrl: cards[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class PokemonCard {
  final String name;
  final String imageUrl;

  PokemonCard({required this.name, required this.imageUrl});

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      name: json['name'],
      imageUrl: json['images']['small'],
    );
  }
}
