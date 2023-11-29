import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furmeetdev/data/models/User.dart';
import 'package:furmeetdev/utils/hash_crypto.dart';

class UserViewModel extends ChangeNotifier {
  String _pseudo = '';
  String _email = '';
  String? _about;
  DateTime _birthDate = DateTime.now();
  //String? _imagePath;
  String? _city;
  String? _gender;
  String _UPASS = '';
  String _SALT = '';
  bool _isDarkMode = false;

  // Getter pour les propriétés
  String get pseudo => _pseudo;
  String get email => _email;
  String? get about => _about;
  DateTime get birthDate => _birthDate;
  //String? get imagePath => _imagePath;
  String? get city => _city;
  String? get gender => _gender;
  String get UPASS => _UPASS;
  String get SALT => _SALT;
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

  set UPASS(String value) {
    _UPASS = value;
    notifyListeners();
  }

  set SALT(String value) {
    _SALT = value;
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
      'UPASS': user.password,
      'SALT': user.salt,
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

  // Fonction pour authentifier l'utilisateur
  Future<bool> authenticateUser(String email, String password) async {
    try {
      // Récupérer les informations de l'utilisateur à partir de l'API
      var response = await http.post(
        Uri.parse('http://192.168.31.61/api_furmeet/user_api.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'uemail': email}),
      );

      if (response.statusCode == 200) {
        // Convertir la réponse JSON en une carte (map)
        var userData = jsonDecode(response.body);

        // Récupérer le sel et le mot de passe haché de la réponse
        String salt = userData['SALT'];
        String hashedPassword = hashPasswordWithSalt(password, salt);

        // Vérifier si le mot de passe haché correspond au mot de passe stocké
        if (hashedPassword == userData['UPASS']) {
          const Duration(milliseconds: 1000);
          // L'authentification réussit
          return true;
        } else {
          // Mot de passe incorrect
          return false;
        }
      } else {
        // Échec de la requête à l'API
        print('Erreur lors de la récupération des informations de l\'utilisateur. Code de statut : ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Gérer les erreurs
      print('Erreur lors de l\'authentification de l\'utilisateur : $e');
      return false;
    }
  }
}

class UserRequest {
  UserRequest({
    required this.identifier,
    required this.password,
  });

  String identifier;
  String password;

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
    identifier: json["identifier"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "password": password,
  };
}