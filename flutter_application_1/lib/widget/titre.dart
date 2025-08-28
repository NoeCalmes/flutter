import 'package:flutter/material.dart';

class Titre extends StatelessWidget {
  const Titre({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Capturez, partager, revivez l\'instant',
      style: TextStyle(
        fontSize: 25,
        fontFamily: 'PragmaticaBook',
        fontWeight: FontWeight.normal,
        color: Colors.black,
        shadows: [
          Shadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            color: const Color.fromARGB(128, 0, 0, 0),
          ),
        ],
      ),
    );
  }
}
