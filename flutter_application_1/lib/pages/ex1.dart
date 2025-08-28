import 'package:flutter/material.dart';

class Ex1 extends StatefulWidget {
  const Ex1({super.key});

  @override
  State<Ex1> createState() => _Ex1State();
}

class _Ex1State extends State<Ex1> {
  @override
  Widget build(BuildContext context) {
       return Scaffold(
      // Barre du haut
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 69, 95, 136),
        title: Text(
          'Ex 1',
          style: TextStyle(color: Colors.white),
        ),
        // Bouton home à gauche
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {},
        ),
        // Bouton paramètres à droite
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      
      // Corps de l'écran
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}