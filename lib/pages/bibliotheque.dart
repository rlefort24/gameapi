// lib/pages/bibliotheque.dart
import 'package:flutter/material.dart';
import 'package:projetapi/pages/widget/card.dart';
import 'package:projetapi/services/rawgio_api.dart';
import '../models/game.dart';

class Bibliotheque extends StatelessWidget {
  const Bibliotheque({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bibliothèque Jeux")),
      body: FutureBuilder<List<Game>>(
        future: ApiService.fetchGames(), // <-- RAWG API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun jeu trouvé"));
          } else {
            final games = snapshot.data!;
            return ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                return GameCard(game: games[index]); // <-- utilise GameCard
              },
            );
          }
        },
      ),
    );
  }
}
