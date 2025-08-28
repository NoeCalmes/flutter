import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.only(top: 150.0, bottom: 30.0),
              child: Image(
                image: AssetImage('assets/img/logo.png'),
                width: 194,
                height: 100,
              ),
            );
  }
}