import 'package:flutter/material.dart';

class textForm extends StatelessWidget {
  final controller;
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  const textForm({
    super.key,
    required this.controller,
    required this.label,
    required this.obscureText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) => value!.isEmpty ? 'Colum ini harus di isi' : null,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
