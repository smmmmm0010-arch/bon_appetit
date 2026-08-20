import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddRecipeDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onRecipeAdded;

  const AddRecipeDialog({super.key, required this.onRecipeAdded});

  @override
  State<AddRecipeDialog> createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends State<AddRecipeDialog> {
  final TextEditingController recipeController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();
  String selectedCategory = 'Dinner';

  @override
  void dispose() {
    recipeController.dispose();
    ingredientsController.dispose();
    stepsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add New Recipe',
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: recipeController,
              decoration: const InputDecoration(labelText: 'Recipe Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ingredientsController,
              decoration: const InputDecoration(labelText: 'Ingredients'),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: stepsController,
              decoration: const InputDecoration(labelText: 'Steps'),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onRecipeAdded({
              'name': recipeController.text,
              'ingredients': ingredientsController.text,
              'steps': stepsController.text,
              'category': selectedCategory,
            });
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
