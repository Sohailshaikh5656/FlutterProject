class Meal {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  bool isFavorite;

  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    this.isFavorite = false,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      category: json['strCategory'],
      imageUrl: json['strMealThumb'],
    );
  }
}
