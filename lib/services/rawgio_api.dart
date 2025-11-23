import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projetapi/services/utils/constants.dart';
import '../models/game.dart';

class ApiService {
  static Future<List<Game>> fetchGames({String? search, String? genre}) async {
    final Map<String, dynamic> queryParameters = {'key': RAWG_API_KEY};
    if (search != null && search.isNotEmpty) {
      queryParameters['search'] = search;
    }
    if (genre != null && genre.isNotEmpty) {
      queryParameters['genres'] = genre.toLowerCase();
    }
    final url = Uri.https('api.rawg.io', '/api/games', queryParameters);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data['results'];
      return results.map((json) => Game.fromJson(json)).toList();
    } else {
      throw Exception('Erreur : ${response.statusCode}');
    }
  }

  static Future<Game> fetchGameDetails(int id) async {
    final url = Uri.https('api.rawg.io', '/api/games/$id', {
      'key': RAWG_API_KEY,
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Game.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erreur : ${response.statusCode}');
    }
  }
}

// https://api.rawg.io/api/games?platforms=6&key=5340b348e4a14f258ddbc8b41f3ffb3f
// attention ? et &
