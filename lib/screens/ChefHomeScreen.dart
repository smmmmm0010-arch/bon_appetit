import 'package:bon_appetit/screens/recipe_details_screen.dart';
import 'package:bon_appetit/widgets/center_add_button.dart';
import 'package:bon_appetit/widgets/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/categorItem.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/home_header.dart';
import 'favorite_screen.dart';

class ChefHomeScreen extends StatefulWidget {
  const ChefHomeScreen({super.key});

  @override
  State<ChefHomeScreen> createState() => _ChefHomeScreenState();
}

class _ChefHomeScreenState extends State<ChefHomeScreen> {
  int _currentBottomIndex = 0;
  final List<Map<String, dynamic>> _recipes = [];
  final List<Map<String, dynamic>> _favorites = [];

  String selectedCategory = 'Dinner';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F4),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF7A85).withOpacity(0.08),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Scaffold(
            backgroundColor: const Color(0xFFFFF7F4),
            body: SafeArea(
              child: _currentBottomIndex == 2
                  ? FavoriteScreen(
                      favorites: _favorites,
                      onDelete: (recipe) {
                        setState(() {
                          _favorites.remove(recipe);
                        });
                      },
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_currentBottomIndex == 2)
                                  FavoriteScreen(
                                    favorites: _favorites,
                                    onDelete: (recipe) {
                                      setState(() {
                                        _favorites.remove(recipe);
                                      });
                                    },
                                  )
                                else ...[
                                  HomeHeader(recipes: _recipes),

                                  const SizedBox(height: 25),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CategoryItem(
                                        name: 'Breakfast',
                                        emoji: '🥞',
                                        color: const Color(0xFF8E60E7),
                                        recipes: _recipes,
                                      ),
                                      CategoryItem(
                                        name: 'Lunch',
                                        emoji: '🍲',
                                        color: const Color(0xFF4CAF50),
                                        recipes: _recipes,
                                      ),
                                      CategoryItem(
                                        name: 'Dinner',
                                        emoji: '🍝',
                                        color: const Color(0xFFFF5A79),
                                        recipes: _recipes,
                                      ),
                                      CategoryItem(
                                        name: 'Dessert',
                                        emoji: '🍰',
                                        color: const Color(0xFFFFB300),
                                        recipes: _recipes,
                                      ),
                                      CategoryItem(
                                        name: 'Drinks',
                                        emoji: '🍹',
                                        color: const Color(0xFFFF9D42),
                                        recipes: _recipes,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 30),

                                  Text(
                                    'My Recipes',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E1435),
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: _recipes.isEmpty
                                        ? Center(
                                            child: Text(
                                              'Your added recipes will appear here 🍴',
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          )
                                        : Column(
                                            children: List.generate(
                                              _recipes.length,
                                              (index) {
                                                final recipe = _recipes[index];

                                                return RecipeCard(
                                                  recipe: recipe,
                                                  isFavorite: _favorites
                                                      .contains(recipe),

                                                  onFavorite: () {
                                                    setState(() {
                                                      if (_favorites.contains(
                                                        recipe,
                                                      )) {
                                                        _favorites.remove(
                                                          recipe,
                                                        );
                                                      } else {
                                                        _favorites.add(recipe);
                                                      }
                                                    });
                                                  },

                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            RecipeDetailsScreen(
                                                              recipeName:
                                                                  recipe['name'],
                                                              ingredients: [
                                                                recipe['ingredients'],
                                                              ],
                                                              steps: [
                                                                recipe['steps'],
                                                              ],
                                                            ),
                                                      ),
                                                    );
                                                  },

                                                  onDelete: () {
                                                    setState(() {
                                                      _recipes.removeAt(index);
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),

            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: _currentBottomIndex,
              onItemSelected: (index) {
                setState(() {
                  _currentBottomIndex = index;
                });
              },
              onRecipeAdded: (newRecipe) {
                setState(() {
                  _recipes.add(newRecipe);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
