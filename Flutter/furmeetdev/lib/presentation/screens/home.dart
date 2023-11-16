import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fur Meet _ Dev'),
      ),
      body: Center(
        child: Text('Bienvenue dans l\'écran principal !'),
      ),
    );
  }
}
