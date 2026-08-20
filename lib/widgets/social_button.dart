import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bon_appetit/screens/BonAppetitCreateAccountScreen.dart';

class SocialButton extends StatelessWidget {
  final String iconText;
  final Color color;

  const SocialButton({super.key, required this.iconText, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.92),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.12), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.18),
            blurRadius: 9,
            spreadRadius: 1,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        iconText,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
