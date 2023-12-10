import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:furmeetdev/data/models/User.dart';
import 'package:furmeetdev/utils/hash_crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int _isDarkMode = 1;

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

  int get isDarkMode => _isDarkMode;

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

  set isDarkMode(int value) {
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
      print(response.statusCode);
      print('Utilisateur enregistré avec succès');
    } else {
      print(
          'Erreur lors de l\'enregistrement de l\'utilisateur. Code de statut : ${response
              .statusCode}');
    }
  }

  // Fonction pour vérifier le mail lors de l'inscription
  Future<bool> isEmailUnique(String email) async {
    try {
      var response = await http.get(
        Uri.parse(
            'http://192.168.31.61/api_furmeet/user_api.php?uemail=$email'),
        headers: {'Content-Type': 'application/json'},
      );

      // Vérification de la réponse JSON
      print(response.statusCode);

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        if (userData != null) {
          return true;
        } else {
          return false;
        }
      } else {
        print(
            'Erreur lors de la vérification de l\'unicité de l\'email. Code de statut : ${response
                .statusCode}');
        return false;
      }
    } catch (e) {
      print('Erreur lors de la vérification de l\'unicité de l\'email : $e');
      return false;
    }
  }

// Fonction pour définir si l'utilisateur est connecté avec une durée de validité du token
  Future<void> setLoggedIn(bool value, String pseudo, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', value);
    prefs.setString('pseudo', pseudo);
    prefs.setString('email', email);

    // Définir une durée de validité du token (par exemple, 7 jours)
    DateTime expirationDate = DateTime.now().add(Duration(days: 365));
    prefs.setString('tokenExpiration', expirationDate.toIso8601String());
  }

// Fonction pour vérifier si le token est encore valide et récupérer les informations
  Future<Map<String, dynamic>> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String pseudo = prefs.getString('pseudo') ?? '';
    String email = prefs.getString('email') ?? '';

    // Vérifier la date d'expiration du token
    String? expirationString = prefs.getString('tokenExpiration');
    DateTime? expirationDate = expirationString != null ? DateTime.parse(expirationString) : null;

    if (expirationDate != null && expirationDate.isAfter(DateTime.now())) {
      // Le token est valide
      return {'isLoggedIn': isLoggedIn, 'pseudo': pseudo, 'email': email};
    } else {
      // Le token a expiré, déconnecter l'utilisateur
      await logout();
      return {'isLoggedIn': false, 'pseudo': '', 'email': ''};
    }
  }

// Fonction pour déconnecter l'utilisateur
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    prefs.remove('pseudo');
    prefs.remove('email');
    prefs.remove('tokenExpiration');
    // Tu peux également effectuer d'autres actions de nettoyage si nécessaire
  }

  // Fonction pour authentifier l'utilisateur
  Future<bool> authenticateUser(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse('http://192.168.31.61/api_furmeet/login_api.php?uemail=$email'),
        headers: {'Content-Type': 'application/json'},
      );

      //print('Raw Response: ${response.body}');

      if (response.statusCode == 200) {
        //var userData = jsonDecode(response.body);
        var userData = jsonDecode(response.body);

        if (userData['success'] == true) {
          // Récupérer le sel et le mot de passe haché de la réponse
          String salt = userData['SALT'];
          String storedHashedPassword = userData['UPASS'];

          // Hacher le mot de passe entré avec le sel
          String hashedPassword = hashPasswordWithSalt(password, salt);

          // Vérifier si le mot de passe haché correspond au mot de passe stocké
          if (hashedPassword == storedHashedPassword) {
            // L'authentification réussit

            // Enregistrer les informations de l'utilisateur dans SharedPreferences
            Map<String, dynamic> user = userData['user'];
            String pseudo = user['upseudo'] ?? '';
            String userEmail = user['uemail'] ?? '';
            print('Pseudo : $pseudo + Email : $userEmail');

            // Utilisez une instance de UserViewModel
            UserViewModel userViewModel = UserViewModel();
            await userViewModel.setLoggedIn(true, pseudo, userEmail);

            return true;
          } else {
            // Mot de passe incorrect
            return false;
          }
        } else {
          // Authentification échouée (peut être à cause d'un email invalide)
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

  // Fonction pour récupérer le profil utilisateur
  Future<Map<String, dynamic>> getProfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? isLoggedIn = prefs.getBool('isLoggedIn');
    final String? email = prefs.getString('email');

    print('Email : $email ------ IsLogged : $isLoggedIn');

    if (isLoggedIn == true) {
      try {
        var response = await http.post(
          Uri.parse('http://192.168.31.61/api_furmeet/profil_api.php'),
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          body: {'uemail': email ?? ''},
        );

        print('Réponse serveur : ${response.body}');

        if (response.statusCode == 200) {
          var userData = jsonDecode(response.body);
          print('Profil récupéré : $userData');

          if (userData['success'] == true) {
            //print(userData);
            return userData['user'];
          } else {
            // Gérer le cas où la récupération du profil échoue
            throw Exception("Échec de récupération du profil");
          }
        } else {
          // Gérer le cas où la requête HTTP échoue
          throw Exception("Échec de la requête HTTP : ${response.statusCode}");
        }
      } catch (e) {
        // Gérer les erreurs autres
        print("Erreur lors de la récupération du profil : $e");
        throw Exception("Erreur lors de la récupération du profil");
      }
    } else {
      // Gérer le cas où l'utilisateur n'est pas connecté
      throw Exception("L'utilisateur n'est pas connecté");
    }
  }


}