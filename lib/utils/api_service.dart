import 'dart:convert';
import 'package:http/http.dart' as http;

// RecipeService class

class RecipeService {
  final String apiKey = '36b8b6939cb14eb7add5546452bcf61f';
  final String baseUrl = 'https://api.spoonacular.com/recipes';

  Future<List<Recipe>> fetchRecipes(String query, {String? diet, bool? random, bool? healthy}) async {
    final dietQuery = diet != null ? '&diet=$diet' : '';
    final randomQuery = random != null && random ? '&random=true' : '';
    final healthyQuery = healthy != null && healthy ? '&maxCalories=500' : ''; // Example filter for healthy
    final response = await http.get(Uri.parse('$baseUrl/complexSearch?query=$query&apiKey=$apiKey$dietQuery$randomQuery$healthyQuery'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      return results.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<RecipeDetails> fetchRecipeDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id/information?apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return RecipeDetails.fromJson(data);
    } else {
      throw Exception('Failed to load recipe details');
    }
  }
}

// Recipe model
class Recipe {
  final int id; // Added to uniquely identify the recipe
  final String title;
  final String imageUrl;

  Recipe({required this.id, required this.title, required this.imageUrl});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'], // Include id in the model
      title: json['title'],
      imageUrl: json['image'],
    );
  }
}

class RecipeDetails {
  final String title;
  final String imageUrl;
  final String instructions;
  final List<String> ingredients;

  RecipeDetails({
    required this.title,
    required this.imageUrl,
    required this.instructions,
    required this.ingredients,
  });

  factory RecipeDetails.fromJson(Map<String, dynamic> json) {
    final instructions = json['instructions'] ?? 'No instructions available';
    final ingredients = (json['extendedIngredients'] as List)
        .map((item) => item['name'])
        .toList()
        .cast<String>();

    return RecipeDetails(
      title: json['title'],
      imageUrl: json['image'],
      instructions: instructions,
      ingredients: ingredients,
    );
  }
}