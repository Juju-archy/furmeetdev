import 'package:flutter/material.dart';
import 'package:furmeetdev/data/models/User.dart';
import 'package:furmeetdev/utils/functions.dart';
import 'package:furmeetdev/utils/hash_crypto.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:furmeetdev/presentation/viewmodels/UserViewModel.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';


class RegistrationUser extends StatefulWidget {
  @override
  _RegistrationUserState createState() => _RegistrationUserState();
}
const List<String> list = <String>[' ', 'Homme', 'Femme', 'Autre'];

class _RegistrationUserState extends State<RegistrationUser> {
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isDarkMode = false;
  String dropdownValue = list.first;

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
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  padding(25.0),
                  const Text(
                    'Inscription',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  padding(10.0),
                  TextFormField(
                    controller: _pseudoController,
                    decoration: InputDecoration(
                      labelText: 'Pseudo',
                      icon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre pseudo';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.mail_outline),
                      border: OutlineInputBorder(),
                    ),
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
                    decoration: InputDecoration(
                      labelText: 'A propos',
                      icon: Icon(Icons.abc),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _birthDateController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Date de naissance",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        print(pickedDate);
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate);

                        setState(() {
                          _birthDateController.text = formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'Ville',
                      icon: Icon(Icons.house_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButton<String>(
                    value: dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black54),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  /*TextFormField(
                    controller: _genderController,
                    decoration: InputDecoration(
                      labelText: 'Genre',
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.transgender)
                    ),
                  ),*/
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.key)
                    ),
                  ),
                  SizedBox(height: 16.0),
                  /*TextFormField(
                    controller: _isDarkModeController,
                    decoration: InputDecoration(labelText: 'isdarkmode'),
                  ),*/
                  Row(
                    children: [
                      Checkbox(
                        value: isDarkMode,
                        checkColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = value ?? false;
                          });
                        },
                      ),
                      Text("Mode sombre"),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {

                        // Utilisation lors de l'enregistrement d'un nouvel utilisateur
                        String salt = generateSalt(); // Générer un sel unique
                        String hashedPassword = hashPasswordWithSalt(_passwordController.text, salt);

                        // Créer un utilisateur à partir des données saisies
                        User newUser = User(
                          pseudo: _pseudoController.text,
                          email: _emailController.text,
                          about: _aboutController.text,
                          birthDate: _birthDateController.text,
                          city: _cityController.text,
                          //gender: _genderController.text,
                          gender: dropdownValue,
                          password: hashedPassword, // Utiliser le mot de passe haché
                          salt: salt, // Stocker le sel dans la base de données
                          isDarkMode: isDarkMode ? 1 : 0,
                        );
                        print(hashedPassword);
                        print(salt);

                        // Utilisez la fonction du ViewModel pour enregistrer l'utilisateur
                        await UserViewModel().registerUser(newUser);

                        // Affichez un message de confirmation
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Inscription réussie'),
                              content: Text('Votre compte a été enregistré avec succès.'),
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
                    child: Text('Inscription',  style: TextStyle(color: Colors.white, fontSize: 25),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        fixedSize: const Size(300, 50),
                        side: const BorderSide(
                            width: 2,
                            color: Colors.pink
                        )
                    ),
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
