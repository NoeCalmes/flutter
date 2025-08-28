import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color _color = Colors.red;

  Map colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'orange': Colors.orange
  };

  void changeColor(String text) {
    setState(() {
      _color = colorMap[text.toLowerCase()] ?? Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 100, height: 100, color: _color),
            SizedBox(height: 20),
            TextField(onChanged: changeColor),
          ],
        ),
      ),
    );
  }
}
