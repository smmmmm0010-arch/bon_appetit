import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget {
  final String name;
  final String emoji;
  final Color color;
  final List<Map<String, dynamic>> recipes;

  const CategoryItem({
    super.key,
    required this.name,
    required this.emoji,
    required this.color,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final categoryRecipes = recipes
            .where((recipe) => recipe['category'] == name)
            .toList();

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color(0xFFFFF7F4),
              title: Text(
                '$emoji $name',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              content: categoryRecipes.isEmpty
                  ? Text('No recipes yet 🍴', style: GoogleFonts.poppins())
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: categoryRecipes.map((recipe) {
                        return ListTile(title: Text(recipe['name'] ?? ''));
                      }).toList(),
                    ),
            );
          },
        );
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(15),
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = currentIndex == index;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFFFF5A79) : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isActive ? 6 : 0,
            height: isActive ? 6 : 0,
            decoration: const BoxDecoration(
              color: Color(0xFFFF5A79),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
