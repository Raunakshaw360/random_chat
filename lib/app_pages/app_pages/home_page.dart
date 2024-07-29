import 'package:flutter/material.dart';
import 'package:random_chat/app_pages/app_pages/recipe_details.dart';
import 'dart:async';

import '../../utils/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  Timer? _autoSlideTimer;
  late Future<List<Recipe>> _recipes;
  final RecipeService recipeService = RecipeService();
  String _diet = ''; // Can be 'vegetarian', 'non-vegetarian', 'vegan', or ''
  String _query = ''; // Search query
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
    _fetchRecipes();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text;
        _fetchRecipes();
      });
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _fetchRecipes() {
    setState(() {
      _recipes = recipeService.fetchRecipes(
        _query,
        diet: _diet.isNotEmpty ? _diet : null,
      );
    });
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page?.toInt() ?? 0) + 1;
        if (nextPage >= 3) nextPage = 0; // Loop back to the first page
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: _recipes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No recipes found.'));
                } else {
                  final recipes = snapshot.data!;
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: 16),
                      if (_query.isEmpty) // Only show sliding cards when query is empty
                        SizedBox(
                          height: 250,
                          child: PageView(
                            controller: _pageController,
                            children: [
                              SlidingCard(
                                imageUrl: 'assets/images/1.jpg',
                                text: 'Card 1',
                              ),
                              SlidingCard(
                                imageUrl: 'assets/images/2.jpg',
                                text: 'Card 2',
                              ),
                              SlidingCard(
                                imageUrl: 'assets/images/3.jpg',
                                text: 'Card 3',
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 20),
                      if (_query.isEmpty) // Only show sliding cards when query is empty
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Popular Dishes',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Create horizontal rows of BottomCard widgets
                      ..._buildCardRows(recipes),
                      SizedBox(height: 20),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCardRows(List<Recipe> recipes) {
    List<Widget> rows = [];
    for (int i = 0; i < recipes.length; i += 2) {
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (i < recipes.length)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: BottomCard(
                      imageUrl: recipes[i].imageUrl,
                      text: recipes[i].title,
                      recipeId: recipes[i].id, // Pass recipe ID
                    ),
                  ),
                ),
              if (i + 1 < recipes.length)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: BottomCard(
                      imageUrl: recipes[i + 1].imageUrl,
                      text: recipes[i + 1].title,
                      recipeId: recipes[i + 1].id, // Pass recipe ID
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }
    return rows;
  }
}

class SlidingCard extends StatelessWidget {
  final String imageUrl;
  final String text;

  SlidingCard({required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          height: 150,
          width: double.infinity,
        ),
      ),
    );
  }
}


class BottomCard extends StatelessWidget {
  final String imageUrl;
  final String text;
  final int recipeId; // Use recipe ID

  BottomCard({required this.imageUrl, required this.text, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(recipeId: recipeId),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
