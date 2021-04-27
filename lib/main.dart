import 'package:flutter/material.dart';
import 'package:pizza_printer_party/home.dart';

void main() {
  runApp(PizzaPartyApp());
}

class PizzaPartyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza Printer Party',
      theme: ThemeData(
        canvasColor: Colors.white70,
        primarySwatch: Colors.deepPurple,
      ),
      home: const PizzaPartyHome(),
    );
  }
}
