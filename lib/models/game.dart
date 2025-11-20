class Game {
  final int id;
  final String name;
  final String released;
  final String image;
  final double rating;

  Game({
    required this.id,
    required this.name,
    required this.released,
    required this.image,
    required this.rating,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'] ?? 'Nom inconnu',
      released: json['released'] ?? 'Date inconnue',
      image: json['background_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }
}
