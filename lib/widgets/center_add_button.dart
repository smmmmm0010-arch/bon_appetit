import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CenterAddButton extends StatefulWidget {
  final int index;
  final int currentBottomIndex;
  final Function(Map<String, dynamic>) onRecipeAdded;

  const CenterAddButton({
    super.key,
    required this.index,
    required this.currentBottomIndex,
    required this.onRecipeAdded,
  });

  @override
  State<CenterAddButton> createState() => _CenterAddButtonState();
}

class _CenterAddButtonState extends State<CenterAddButton> {
  final recipeController = TextEditingController();
  final ingredientsController = TextEditingController();
  final stepsController = TextEditingController();
  String selectedCategory = 'Breakfast';

  @override
  void dispose() {
    recipeController.dispose();
    ingredientsController.dispose();
    stepsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isActive = widget.currentBottomIndex == widget.index;

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFFFFF7F4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: Text(
              'Add New Recipe 👨‍🍳',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E1435),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: recipeController,
                  decoration: InputDecoration(
                    hintText: 'Recipe Name...',
                    hintStyle: GoogleFonts.poppins(fontSize: 13),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFFFF5A79),
                    ),
                  ),
                  items: ['Breakfast', 'Lunch', 'Dinner', 'Dessert', 'Drinks']
                      .map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(
                            category,
                            style: GoogleFonts.poppins(fontSize: 13),
                          ),
                        );
                      })
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: ingredientsController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Ingredients...',
                    hintStyle: GoogleFonts.poppins(fontSize: 13),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: stepsController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'How to make it...',
                    hintStyle: GoogleFonts.poppins(fontSize: 13),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5A79),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if (recipeController.text.isEmpty) return;

                  widget.onRecipeAdded({
                    'name': recipeController.text,
                    'category': selectedCategory,
                    'ingredients': ingredientsController.text,
                    'steps': stepsController.text,
                  });

                  recipeController.clear();
                  ingredientsController.clear();
                  stepsController.clear();
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Recipe Added Successfully! 🎉'),
                      backgroundColor: Color(0xFFFF5A79),
                    ),
                  );
                },
                child: Text(
                  'Add',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFFFF4B72), Color(0xFFFF9D42)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF4B72).withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const Center(
          child: Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
