import 'package:flutter/material.dart';
import '../../utils/api_service.dart';

class DetailScreen extends StatelessWidget {
  final int recipeId; // Use recipe ID to fetch details

  DetailScreen({required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final RecipeService recipeService = RecipeService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Details'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<RecipeDetails>(
          future: recipeService.fetchRecipeDetails(recipeId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No details available.'));
            } else {
              final recipeDetails = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(recipeDetails.imageUrl, fit: BoxFit.cover, height: 200, width: double.infinity),
                    SizedBox(height: 16),
                    Text(
                      recipeDetails.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      recipeDetails.instructions,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Ingredients:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ...recipeDetails.ingredients.map((ingredient) => Text('- $ingredient')).toList(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
