import 'package:flutter/material.dart';

class HomeComercianteScreen extends StatelessWidget {
  const HomeComercianteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Home Comerciante (em construção)",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}