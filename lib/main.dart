import 'package:flutter/material.dart';
import 'package:servian_assignment/Screens/HomeScreen.dart';

void main() {
  runApp(const ServianApp());
}

class ServianApp extends StatelessWidget {
  const ServianApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Servian',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
