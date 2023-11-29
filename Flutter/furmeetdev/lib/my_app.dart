import 'package:flutter/material.dart';
import 'package:furmeetdev/presentation/screens/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furmeetdev/providers.dart';
import 'package:furmeetdev/presentation/screens/connectionPage/login_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isAuthenticated = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fur Meet',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(100, 78, 64, 100.0),
        ),
        useMaterial3: true,
      ),
      home: isAuthenticated ? MyHomePage(title: 'Fur Meet') : LoginScreen(),
    );
  }
}
