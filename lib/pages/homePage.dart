import 'package:flutter/material.dart';
import 'package:projetapi/models/game.dart';
import 'package:projetapi/services/rawgio_api.dart';
import 'package:projetapi/pages/widget/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Game>> futureGames;
  String selectedGenre = "All";
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  void fetchGames() {
    setState(() {
      futureGames = ApiService.fetchGames(
        search: searchQuery,
        genre: selectedGenre == "All"
            ? null
            : (selectedGenre == "RPG"
                  ? "role-playing-games-rpg"
                  : selectedGenre.toLowerCase().replaceAll(" ", "-")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 2, 2),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 9, 39),
        title: Text(
          widget.title,
          style: TextStyle(color: Color.fromARGB(255, 202, 202, 202)),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 30, 30, 30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: selectedGenre,
                    dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                    style: const TextStyle(color: Colors.white),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    underline: Container(),
                    items:
                        [
                          "All",
                          "Action",
                          "RPG",
                          "Shooter",
                          "Adventure",
                          "Indie",
                          "Strategy",
                          "Casual",
                          "Simulation",
                          "Puzzle",
                          "Arcade",
                          "Platformer",
                          "Massively Multiplayer",
                          "Racing",
                          "Sports",
                          "Fighting",
                          "Family",
                          "Board Games",
                          "Card",
                          "Educational",
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedGenre = newValue;
                        });
                        fetchGames();
                      }
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Rechercher un jeu",
                      labelStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 30, 30, 30),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: const Icon(Icons.search, color: Colors.white),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                      fetchGames();
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Game>>(
              future: futureGames,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erreur : ${snapshot.error}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "Aucun jeu trouvé",
                      style: const TextStyle(color: Colors.white),
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
          ),
        ],
      ),
    );
  }
}
