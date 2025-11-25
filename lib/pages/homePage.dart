import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projetapi/models/game.dart';
import 'package:projetapi/services/rawgio_api.dart';
import 'package:projetapi/pages/widget/card.dart';
import 'package:projetapi/pages/played_games_page.dart';
import 'package:projetapi/pages/to_play_games_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavigationPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 0, 17, 255),
            const Color.fromARGB(255, 160, 24, 24),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/Gemini_Generated_Image_jppykxjppykxjppy.png',
            width: 400,
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(color: Color.fromARGB(248, 192, 157, 0)),
        ],
      ),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const GameDiscoveryPage(),
    const PlayedGamesPage(),
    const ToPlayGamesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 2, 2),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 8, 9, 39),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Played',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: 'To Play',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 202, 202, 202),
        unselectedItemColor: Colors.white54,
        onTap: _onItemTapped,
      ),
    );
  }
}

class GameDiscoveryPage extends StatefulWidget {
  const GameDiscoveryPage({super.key});

  @override
  State<GameDiscoveryPage> createState() => _GameDiscoveryPageState();
}

class _GameDiscoveryPageState extends State<GameDiscoveryPage> {
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
        genre: selectedGenre == "All" ? null : selectedGenre,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 2, 2),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 9, 39),
        title: const Text(
          "Game API",
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
                  height: 45,
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

                const SizedBox(width: 16),

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
