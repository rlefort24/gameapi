import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<String?> getGameStatus(int gameId) async {
    try {
      final response = await _client
          .from('user_games')
          .select('status')
          .eq('game_id', gameId)
          .maybeSingle();

      if (response != null) {
        return response['status'] as String;
      }
    } catch (e) {
      print('Erreur lors de la récupération du statut : $e');
    }
    return null;
  }

  Future<void> addToPlay(int gameId) async {
    try {
      await _client.from('user_games').upsert({
        'game_id': gameId,
        'status': 'to_play',
      }, onConflict: 'game_id');
    } catch (e) {
      print('Erreur lors de l\'ajout à "À jouer" : $e');
    }
  }

  Future<void> addPlayed(int gameId) async {
    try {
      await _client.from('user_games').upsert({
        'game_id': gameId,
        'status': 'played',
      }, onConflict: 'game_id');
    } catch (e) {
      print('Erreur lors de l\'ajout à "Déjà joué" : $e');
    }
  }

  Future<void> removeGame(int gameId) async {
    try {
      await _client.from('user_games').delete().eq('game_id', gameId);
    } catch (e) {
      print('Erreur lors de la suppression du jeu : $e');
    }
  }

  Future<List<int>> getGamesByStatus(String status) async {
    try {
      final response = await _client
          .from('user_games')
          .select('game_id')
          .eq('status', status);

      return response.map((item) => item['game_id'] as int).toList();
    } catch (e) {
      print('Erreur lors de la récupération des jeux par statut : $e');
      return [];
    }
  }

  Future<List<int>> getToPlayGames() async {
    return await getGamesByStatus('to_play');
  }

  Future<List<int>> getPlayedGames() async {
    return await getGamesByStatus('played');
  }
}
