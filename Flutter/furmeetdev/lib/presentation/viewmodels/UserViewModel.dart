import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserViewModel extends ChangeNotifier {
  String _pseudo = '';
  String _email = '';
  String? _about;
  DateTime _birthDate = DateTime.now();
  String? _imagePath;
  String? _city;
  String? _gender;
  bool _isDarkMode = false;

  // Getter pour les propriétés
  String get pseudo => _pseudo;
  String get email => _email;
  String? get about => _about;
  DateTime get birthDate => _birthDate;
  String? get imagePath => _imagePath;
  String? get city => _city;
  String? get gender => _gender;
  bool get isDarkMode => _isDarkMode;

  // Setter pour les propriétés
  set pseudo(String value) {
    _pseudo = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set about(String? value) {
    _about = value;
    notifyListeners();
  }

  set birthDate(DateTime value) {
    _birthDate = value;
    notifyListeners();
  }

  set imagePath(String? value) {
    _imagePath = value;
    notifyListeners();
  }

  set city(String? value) {
    _city = value;
    notifyListeners();
  }

  set gender(String? value) {
    _gender = value;
    notifyListeners();
  }

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  // Fonction pour enregistrer l'utilisateur
  Future<void> registerUser() async {
    var userData = {
      'pseudo': _pseudo,
      'email': _email,
      'about': _about,
      'birthDate': _birthDate.toIso8601String(),
      'imagePath': _imagePath,
      'city': _city,
      'gender': _gender,
      'isDarkMode': _isDarkMode.toString(),
    };

    // Envoyer les données à l'API
    var response = await http.post(
      Uri.parse('http://votre-serveur/api.php'), // Remplacez par l'URL de votre API
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    // Vérifier la réponse de l'API
    if (response.statusCode == 200) {
      print('Utilisateur enregistré avec succès');
    } else {
      print('Erreur lors de l\'enregistrement de l\'utilisateur. Code de statut : ${response.statusCode}');
    }

    // Utilisez les propriétés actuelles du ViewModel pour enregistrer l'utilisateur
    // Vous pouvez ajouter ici la logique d'enregistrement, par exemple, l'envoi des données à un backend
    print('Enregistrement de l\'utilisateur avec les données suivantes:');
    print('Pseudo: $_pseudo');
    print('Email: $_email');
    print('About: $_about');
    print('Date de naissance: $_birthDate');
    print('Image Path: $_imagePath');
    print('Ville: $_city');
    print('Genre: $_gender');
    print('Mode sombre: $_isDarkMode');
  }
}