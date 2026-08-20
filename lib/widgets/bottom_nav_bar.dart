import 'package:flutter/material.dart';
import 'package:bon_appetit/widgets/categorItem.dart';
import 'package:bon_appetit/widgets/center_add_button.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;
  final Function(Map<String, dynamic>) onRecipeAdded;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
    required this.onRecipeAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomNavItem(
            index: 0,
            currentIndex: currentIndex,
            icon: Icons.home_rounded,
            onTap: () => onItemSelected(0),
          ),

          CenterAddButton(
            index: 4,
            currentBottomIndex: currentIndex,
            onRecipeAdded: onRecipeAdded,
          ),

          BottomNavItem(
            index: 2,
            currentIndex: currentIndex,
            icon: Icons.favorite_border_rounded,
            onTap: () => onItemSelected(2),
          ),
        ],
      ),
    );
  }
}
