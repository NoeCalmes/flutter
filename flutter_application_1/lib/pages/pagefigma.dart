import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/logo.dart';
import 'package:flutter_application_1/widget/titre.dart';

class Pagefigma extends StatefulWidget {
  const Pagefigma({super.key});

  @override
  State<Pagefigma> createState() => _PagefigmaState();
}

class _PagefigmaState extends State<Pagefigma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Logo(),
            Titre(),
            Spacer(),
            Container(color: Colors.white, width: double.infinity),
          ],
        ),
      ),
    );
  }
}
