import 'package:flutter/material.dart';
import 'package:furmeetdev/presentation/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(100, 78, 64, 100.0)),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
