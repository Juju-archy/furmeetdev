import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furmeetdev/data/models/User.dart';

class UserViewModel extends ChangeNotifier {
  String _pseudo = '';
  String _email = '';
  String? _about;
  DateTime _birthDate = DateTime.now();
  //String? _imagePath;
  String? _city;
  String? _gender;
  bool _isDarkMode = false;

  // Getter pour les propriétés
  String get pseudo => _pseudo;
  String get email => _email;
  String? get about => _about;
  DateTime get birthDate => _birthDate;
  //String? get imagePath => _imagePath;
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

  /*set imagePath(String? value) {
    _imagePath = value;
    notifyListeners();
  }*/

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
  Future<void> registerUser(User user) async {
    var userData = {
      'uemail': user.email,
      'upseudo': user.pseudo,
      'uabout': user.about,
      'ubirthday': user.birthDate,
      'ucity': user.city,
      'ugender': user.gender,
      'UPASS': user.password, // Ajoutez cette ligne si vous avez un champ de mot de passe dans votre modèle User
      'isdarkmode': user.isDarkMode,
    };

    // Envoyer les données à l'API
    var response = await http.post(
      Uri.parse('http://192.168.31.61/api_furmeet/user_api.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    // Vérifier la réponse de l'API
    if (response.statusCode == 200) {
      print('Utilisateur enregistré avec succès');
    } else {
      print('Erreur lors de l\'enregistrement de l\'utilisateur. Code de statut : ${response.statusCode}');
    }
  }
}