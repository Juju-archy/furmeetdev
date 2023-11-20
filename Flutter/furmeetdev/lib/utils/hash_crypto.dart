import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

String hashPassword(String password) {
  var bytes = utf8.encode(password);
  var digest = sha512.convert(bytes);
  return digest.toString();
}

// Fonction pour hacher le mot de passe avec un sel
String hashPasswordWithSalt(String password, String salt) {
  var bytes = utf8.encode(password + salt);
  var digest = sha512.convert(bytes);
  return digest.toString();
}

// Fonction pour générer le salt
String generateSalt() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return List.generate(16, (index) => chars[random.nextInt(chars.length)]).join();
}