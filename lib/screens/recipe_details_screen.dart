import 'package:bon_appetit/screens/ChefHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final String recipeName;
  final List<String> ingredients;
  final List<String> steps;

  const RecipeDetailsScreen({
    super.key,
    required this.recipeName,
    required this.ingredients,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF5A79),
        foregroundColor: Colors.white,
        title: Text(
          recipeName,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '🍝 $recipeName',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1435),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              'Ingredients',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF5A79),
              ),
            ),

            const SizedBox(height: 10),

            ...ingredients.map(
              (ingredient) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(fontSize: 18, color: Color(0xFFFF5A79)),
                    ),
                    Expanded(
                      child: Text(
                        ingredient,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF1E1435),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              'How to Make It',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF5A79),
              ),
            ),

            const SizedBox(height: 10),

            ...List.generate(
              steps.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5A79),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${index + 1}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        steps[index],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF1E1435),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
