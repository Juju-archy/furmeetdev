import 'package:flutter/material.dart';
import 'package:furmeetdev/presentation/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fur Meet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(100, 78, 64, 100.0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fur Meet'),
    );
  }
}