import 'package:flutter/material.dart';
import 'package:projetapi/models/game.dart';
import 'package:projetapi/services/rawgio_api.dart';

class DetailPage extends StatefulWidget {
  final int gameId;
  final Game initialGameData;

  const DetailPage({
    super.key,
    required this.gameId,
    required this.initialGameData,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Game> futureGameDetails;

  @override
  void initState() {
    super.initState();
    futureGameDetails = ApiService.fetchGameDetails(widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 2, 2),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 9, 39),
        title: Text(
          widget.initialGameData.name,
          style: const TextStyle(color: Color.fromARGB(255, 202, 202, 202)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<Game>(
        future: futureGameDetails,
        initialData: widget.initialGameData,
        builder: (context, snapshot) {
          final game = snapshot.data!;

          if (snapshot.hasError) {}

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (game.image.isNotEmpty)
                  Image.network(
                    game.image,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              game.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              game.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Sortie : ${game.released}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                              game.description.isNotEmpty
                                  ? game.description
                                  : "Aucune description disponible.",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
