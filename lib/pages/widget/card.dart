import 'package:flutter/material.dart';
import 'package:projetapi/models/game.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(17),
      color: Color.fromARGB(255, 47, 2, 58),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              game.name,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 252, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Date de sortie : ${game.released}",
              style: TextStyle(color: Color.fromARGB(255, 252, 255, 255)),
            ),
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
