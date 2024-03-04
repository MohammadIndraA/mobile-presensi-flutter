import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class textField extends StatelessWidget {
  final controller;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  const textField({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(
          label,
          style: GoogleFonts.urbanist(
            color: Color(0xff8390a1),
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
