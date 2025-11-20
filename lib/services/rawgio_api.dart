import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetapi/services/utils/constants.dart';
import '../models/game.dart'; // modèle Dart pour un jeu

class ApiService {
  // Récupérer la liste des jeux
  static Future<List<Game>> fetchGames() async {
    final url = Uri.parse(
      'https://api.rawg.io/api/games?key=$RAWG_API_KEY'
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data['results']; // RAWG renvoie la liste dans 'results'
      return results.map((json) => Game.fromJson(json)).toList();
    } else {
      throw Exception('Erreur : ${response.statusCode}');
    }
  }
}


//https://api.rawg.io/api/games?platforms=6&key=5340b348e4a14f258ddbc8b41f3ffb3f
// attention ? et &
//