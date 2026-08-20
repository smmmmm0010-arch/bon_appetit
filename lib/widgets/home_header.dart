import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bon_appetit/screens/recipe_details_screen.dart';
import 'package:bon_appetit/data/recipeData.dart';

class HomeHeader extends StatefulWidget {
  final List<Map<String, dynamic>> recipes;

  const HomeHeader({super.key, required this.recipes});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final searchResults = widget.recipes
        .where(
          (recipe) => recipe['name'].toString().toLowerCase().contains(
            searchText.toLowerCase(),
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(
                        'Hi, Chef! ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF6E6A7C),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text('👋', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'What are you\ncooking today?',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E1435),
                    height: 1.2,
                  ),
                ),
              ],
            ),

            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFEE72), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFEE72).withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 26,
                backgroundColor: Color(0xFFFFF0EA),
                child: Text('🍓', style: TextStyle(fontSize: 28)),
              ),
            ),
          ],
        ),

        const SizedBox(height: 25),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search recipes, ingredients...',
              hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
                size: 22,
              ),
              suffixIcon: Container(
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF4B72), Color(0xFFFF7A85)],
                  ),
                ),
                child: const Icon(Icons.search, color: Colors.white, size: 18),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),

        // نتائج البحث
        if (searchText.isNotEmpty && searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: searchResults.map((recipe) {
                return ListTile(
                  leading: const Text('🍴', style: TextStyle(fontSize: 25)),
                  title: Text(
                    recipe['name'] ?? '',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    recipe['category'] ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailsScreen(
                          recipeName: recipe['name'],
                          ingredients: [recipe['ingredients']],
                          steps: [recipe['steps']],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),

        const SizedBox(height: 25),

        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFF5A79), Color(0xFFFF9D42)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF5A79).withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        '✦ Today\'s Special',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      'Creamy Garlic\nPasta',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),

                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.white70,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '25 min',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.circle,
                          color: Colors.white70,
                          size: 4,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Easy',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailsScreen(
                              recipeName: 'pasta 🍝',
                              ingredients: Recipedata.pastaIngredients,
                              steps: Recipedata.pastaSteps,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'View Recipe',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFFFF5A79),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                right: -10,
                bottom: 10,
                top: 10,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/pasta.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 15,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Color(0xFFFF4B72),
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
