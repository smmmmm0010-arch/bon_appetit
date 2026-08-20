import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/recipe_card.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favorites;
  final Function(Map<String, dynamic>) onDelete;

  const FavoriteScreen({
    super.key,
    required this.favorites,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F4),

      appBar: AppBar(
        backgroundColor: const Color(0xFFFF4B72),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Favorites ❤️',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),

      body: favorites.isEmpty
          ? Center(
              child: Text(
                'No favorite recipes yet ❤️',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final recipe = favorites[index];

                return RecipeCard(
                  recipe: recipe,
                  isFavorite: true,

                  onFavorite: () {
                    onDelete(recipe);
                  },

                  onDelete: () {
                    onDelete(recipe);
                  },

                  onTap: () {},
                );
              },
            ),
    );
  }
}
