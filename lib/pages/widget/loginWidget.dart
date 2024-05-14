import 'package:flutter/material.dart';

class Titular extends StatelessWidget {
  final String title;

  const Titular({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40)));
  }
}
