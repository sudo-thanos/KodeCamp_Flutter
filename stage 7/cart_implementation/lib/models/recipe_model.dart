class Recipe {
  final int id;
  final String name;
  final String image;
  final String cuisine;
  final String difficulty;
  final int cookTimeMinutes;
  final int prepTimeMinutes;
  final double rating;
  final int reviewCount;
  final int servings;
  final int caloriesPerServing;
  final List<String> ingredients;
  final List<String> instructions;
  final List<String> tags;

  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.cuisine,
    required this.difficulty,
    required this.cookTimeMinutes,
    this.prepTimeMinutes = 0,
    required this.rating,
    required this.reviewCount,
    this.servings = 0,
    this.caloriesPerServing = 0,
    this.ingredients = const [],
    this.instructions = const [],
    this.tags = const [],
  });

  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;

  // The recipes API this app pulls from (dummyjson.com/recipes) has no price
  // field, but Cart/Checkout need one - derive a stable mock price from the
  // recipe id so the same recipe always costs the same amount.
  double get price => 4.5 + (id % 12) * 1.35;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      cuisine: json['cuisine'] ?? '',
      difficulty: json['difficulty'] ?? '',
      cookTimeMinutes: json['cookTimeMinutes'] ?? 0,
      prepTimeMinutes: json['prepTimeMinutes'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      servings: json['servings'] ?? 0,
      caloriesPerServing: json['caloriesPerServing'] ?? 0,
      ingredients: (json['ingredients'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      instructions: (json['instructions'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      tags: (json['tags'] as List? ?? []).map((e) => e.toString()).toList(),
    );
  }
}
