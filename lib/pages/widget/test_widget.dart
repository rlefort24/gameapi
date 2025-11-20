import 'package:flutter/material.dart';
import 'package:projetapi/models/game.dart';
import 'package:projetapi/pages/widget/card.dart';

class TestWidgetPage extends StatelessWidget {
  const TestWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Données mock pour tester les widgets
    final List<Game> mockGames = [
      
      Game(
        id: 2,
        name: "Cyberpunk 2077",
        released: "2020-12-10",
        image: "https://images.igdb.com/igdb/image/upload/t_cover_big/co1xdp.jpg",
        rating: 4.2,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Test Widgets")),
      body: ListView.builder(
        itemCount: mockGames.length,
        itemBuilder: (context, index) {
          return GameCard(game: mockGames[index]);
        },
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TestWidgetPage(), // <-- page de test
    );
  }
}
