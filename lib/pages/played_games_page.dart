import 'package:flutter/material.dart';
import 'package:projetapi/models/game.dart';
import 'package:projetapi/services/rawgio_api.dart';
import 'package:projetapi/services/supabase_service.dart';
import 'package:projetapi/pages/widget/card.dart';

class PlayedGamesPage extends StatefulWidget {
  const PlayedGamesPage({super.key});

  @override
  State<PlayedGamesPage> createState() => _PlayedGamesPageState();
}

class _PlayedGamesPageState extends State<PlayedGamesPage> {
  final SupabaseService _supabaseService = SupabaseService();
  late Future<List<Game>> _futureGames;

  @override
  void initState() {
    super.initState();
    _futureGames = _loadGames();
  }

  Future<List<Game>> _loadGames() async {
    try {
      final gameIds = await _supabaseService.getPlayedGames();

      if (gameIds.isEmpty) {
        return [];
      }

      List<Game> games = [];
      for (int gameId in gameIds) {
        try {
          final game = await ApiService.fetchGameById(gameId);
          if (game != null) {
            games.add(game);
          }
        } catch (e) {
          print('Erreur lors de la récupération du jeu $gameId : $e');
        }
      }

      return games;
    } catch (e) {
      print('Erreur lors du chargement des jeux : $e');
      return [];
    }
  }

  void _refreshGames() {
    setState(() {
      _futureGames = _loadGames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 2, 2),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 9, 39),
        title: const Text(
          "Played",
          style: TextStyle(color: Color.fromARGB(255, 202, 202, 202)),
        ),
      ),
      body: FutureBuilder<List<Game>>(
        future: _futureGames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 37, 136, 18),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    "Erreur : ${snapshot.error}",
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshGames,
                    child: const Text("Réessayer"),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white54,
                    size: 80,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "No games played yet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Mark games as played from the home page!",
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            );
          }

          final games = snapshot.data!;

          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              return GameCard(game: games[index]);
            },
          );
        },
      ),
    );
  }
}
