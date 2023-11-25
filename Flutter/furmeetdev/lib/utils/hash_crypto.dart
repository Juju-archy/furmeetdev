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

// Fonction pour vérifier le mot de passe
bool passwordVerify(String password, String storedHash) {
  // Récupère le sel du hachage stocké (les 128 premiers caractères)
  String storedSalt = storedHash.substring(0, 128);

  // Génère le hachage du mot de passe fourni avec le sel récupéré
  String inputHash = hashPasswordWithSalt(password, storedSalt);

  // Compare les hachages
  return inputHash == storedHash;
}