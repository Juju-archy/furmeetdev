import 'package:flutter/material.dart';
import 'package:furmeetdev/data/models/User.dart';
import 'package:furmeetdev/utils/functions.dart';
import 'package:furmeetdev/utils/hash_crypto.dart';

class RegistrationUser extends StatefulWidget {
  @override
  _RegistrationUserState createState() => _RegistrationUserState();
}

class _RegistrationUserState extends State<RegistrationUser> {
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _isDarkModeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Inscription'),
      ),
      body: GestureDetector(
        onTap: () {
          // Permet de masquer le clavier lorsque l'utilisateur tape n'importe où en dehors des champs de texte
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  padding(10.0),
                  TextFormField(
                    controller: _pseudoController,
                    decoration: InputDecoration(labelText: 'Pseudo'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir un pseudo';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir un e-mail';
                      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                        return 'Veuillez saisir un e-mail valide';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _aboutController,
                    decoration: InputDecoration(labelText: 'À propos'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _birthDateController,
                    decoration: InputDecoration(labelText: 'Date de naissance'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _imagePathController,
                    decoration: InputDecoration(labelText: 'Chemin de l\'image'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(labelText: 'Ville'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _genderController,
                    decoration: InputDecoration(labelText: 'Genre'),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _isDarkModeController,
                    decoration: InputDecoration(labelText: 'Mode sombre (true/false)'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Créer un utilisateur à partir des données saisies
                        User newUser = User(
                          pseudo: _pseudoController.text,
                          email: _emailController.text,
                          about: _aboutController.text,
                          birthDate: DateTime.parse(_birthDateController.text),
                          imagePath: _imagePathController.text,
                          city: _cityController.text,
                          gender: _genderController.text,
                          isDarkMode: _isDarkModeController.text.toLowerCase() == 'false',
                        );

                        // Utilisez cet utilisateur comme bon vous semble (par exemple, enregistrez-le dans une base de données)
                        // ...

                        // Affichez un message de confirmation
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Inscription réussie'),
                              content: Text('L\'utilisateur a été enregistré avec succès.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text('S\'inscrire'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
