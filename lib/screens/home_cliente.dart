import 'package:flutter/material.dart';

class HomeClienteScreen extends StatelessWidget {
  const HomeClienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Home Cliente (em construção)",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}