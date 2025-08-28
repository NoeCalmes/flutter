import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Ex1.dart';
import 'package:flutter_application_1/pages/dojo2.dart';
import 'package:flutter_application_1/pages/pagefigma.dart';
import 'pages/home.dart';
import 'pages/ex2.dart';
import 'pages/ex3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Dojo2());
  }
}
