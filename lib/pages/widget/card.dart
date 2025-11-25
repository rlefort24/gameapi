import 'package:flutter/material.dart';
import 'package:projetapi/models/game.dart';
import 'package:projetapi/pages/detailPage.dart';
import 'package:projetapi/services/supabase_service.dart';

class GameCard extends StatefulWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  bool toPlay = false;
  bool played = false;
  final SupabaseService _supabaseService = SupabaseService();

  @override
  void initState() {
    super.initState();
    _checkGameStatus();
  }

  Future<void> _checkGameStatus() async {
    final status = await _supabaseService.getGameStatus(widget.game.id);
    if (mounted) {
      setState(() {
        toPlay = status == 'to_play';
        played = status == 'played';
      });
    }
  }

  Future<void> _toggleToPlay() async {
    setState(() {
      toPlay = !toPlay;
      if (toPlay) played = false;
    });

    if (toPlay) {
      await _supabaseService.addToPlay(widget.game.id);
    } else {
      await _supabaseService.removeGame(widget.game.id);
    }
  }

  Future<void> _togglePlayed() async {
    setState(() {
      played = !played;
      if (played) toPlay = false;
    });

    if (played) {
      await _supabaseService.addPlayed(widget.game.id);
    } else {
      await _supabaseService.removeGame(widget.game.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 6,
      color: const Color.fromARGB(255, 30, 30, 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                gameId: widget.game.id,
                initialGameData: widget.game,
              ),
            ),
          );
        },
        hoverColor: Colors.white.withOpacity(0.1),
        splashColor: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.game.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Game released : ${widget.game.released}",
                style: TextStyle(color: Color.fromARGB(255, 252, 255, 255)),
              ),
              const SizedBox(height: 8),
              widget.game.image.isNotEmpty
                  ? Image.network(widget.game.image)
                  : const SizedBox(),

              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: _toggleToPlay,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: toPlay
                            ? const Color.fromARGB(255, 1, 99, 190)
                            : Colors.transparent,
                        border: Border.all(
                          color: const Color.fromARGB(255, 1, 99, 190),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "To Play",
                        style: TextStyle(
                          color: toPlay
                              ? Colors.white
                              : const Color.fromARGB(255, 1, 99, 190),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: _togglePlayed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: played
                            ? const Color.fromARGB(255, 37, 136, 18)
                            : Colors.transparent,
                        border: Border.all(
                          color: const Color.fromARGB(255, 37, 136, 18),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Played",
                        style: TextStyle(
                          color: played
                              ? Colors.white
                              : const Color.fromARGB(255, 37, 136, 18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
