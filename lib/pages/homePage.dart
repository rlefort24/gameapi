import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 2, 2),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 9, 39),
        title: Text(widget.title ,style:TextStyle(color: Color.fromARGB(255, 202, 202, 202)) ,),
      ),
      body: Column(
  children: [
    // ------------------------------
    // 🔹 Ligne du haut : Genres + Barre de recherche
    // ------------------------------
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          // 👉 Liste verticale des genres (à gauche)
          Container(
            width: 120,
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 30, 30, 30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: "Action",
              dropdownColor: const Color.fromARGB(255, 30, 30, 30),
              style: const TextStyle(color: Colors.white),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              isExpanded: true,
              underline: Container(),
              items: ["Action", "RPG", "Shooter", "Adventure", "Indie"]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(value),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                // TODO: Gérer le changement de genre
              },
            ),
          ),

          const SizedBox(width: 16),

          // 👉 Champ de recherche (à droite)
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
            ),
          ),
        ],
      ),
    ),

    // ------------------------------
    // 🔹 Liste des jeux 
    // (où tu vas appeler tes GameCard(game))
    // ------------------------------
    Expanded(
      child: ListView.builder(
        itemCount: 10, // à remplacer par ta future liste
        itemBuilder: (context, index) {
          // TODO : Remplacer par GameCard(game: maListe[index])
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "Jeu n°$index (placeholder)",
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    ),

  ],
),

    );
  }
}
