import 'package:flutter/material.dart';

class Dojo2 extends StatefulWidget {
  const Dojo2({super.key});

  @override
  State<Dojo2> createState() => _Dojo2State();
}

class _Dojo2State extends State<Dojo2> {
  Map colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'orange': Colors.orange,
  };

  Color containerColor = Colors.red;

  void changeColor(String text) {
    setState(() {
      containerColor = colorMap[text] ?? Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(color: containerColor, height: 200, width: 200),
            SizedBox(height: 20),
            TextField(onChanged: changeColor),
          ],
        ),
      ),
    );
  }
}
