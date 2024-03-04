import 'package:flutter/material.dart';
import 'package:get/get.dart';

class textButtom extends StatelessWidget {
  const textButtom(
      {super.key, this.controllers, required this.text, this.Routess});

  final controllers;
  final String text;
  final Routess;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.offAllNamed(Routess);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 28, 73, 110),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
