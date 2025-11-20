import 'package:flutter/material.dart';
import 'package:projetapi/models/game.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(17),
      color: Color.fromARGB(255, 255, 3, 3),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(game.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("Date de sortie : ${game.released}"),
            const SizedBox(height: 4),
            Text("Note : ${game.rating}"),
            const SizedBox(height: 8),
            game.image.isNotEmpty
                ? Image.network(game.image)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
