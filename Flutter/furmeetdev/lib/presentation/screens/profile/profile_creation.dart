import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furmeetdev/data/models/User.dart';
import 'package:furmeetdev/presentation/screens/connectionPage/login_screen.dart';
import 'package:furmeetdev/utils/functions.dart';
import 'package:furmeetdev/utils/hash_crypto.dart';
import 'package:furmeetdev/presentation/viewmodels/UserViewModel.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_field_validator/form_field_validator.dart';


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
  final TextEditingController _confirmPass = TextEditingController();

  final bool isDarkMode = false;
  String dropdownValue = list.first;
  bool _isVisible = false;
  bool _isVisible1 = false;

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
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  padding(20.0),
                  const Text(
                    'Inscription',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  padding(30.0),
                  TextFormField(
                    controller: _pseudoController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(45)
                    ],
                    decoration: InputDecoration(
                      labelText: 'Pseudo',
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
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(45)
                    ],
                    decoration: InputDecoration(
                      labelText: 'Email\'',
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
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 5,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(500)
                    ],
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _birthDateController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Requis"),
                    ]),
                    decoration: InputDecoration(
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
                        print("Veuillez sélectionner votre date de naissance");
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'Ville',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Genre',
                      border: OutlineInputBorder(),
                    ),
                    value: dropdownValue,
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
                  SizedBox(height: 16.0),
                  TextFormField(
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Requis"),
                      MinLengthValidator(8,
                          errorText:
                          "Le mot de passe doit faire minimum 8 caractères"),
                      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                          errorText:
                          'Le mot de passe doit contenir au minimum un caractère spéciale'),
                      MaxLengthValidator(64,
                          errorText:
                          "Le mot de passe ne doit pas dépasser 64 caractères")
                    ]),
                    obscureText: !_isVisible,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_isVisible ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() {
                          _isVisible = !_isVisible;
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                      obscureText: !_isVisible1,
                      controller: _confirmPass,
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_isVisible1 ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() {
                            _isVisible1 = !_isVisible1;
                          }),
                        ),
                      ),
                      validator: (val){
                        if(val!.isEmpty)
                          return 'Empty';
                        if(val != _passwordController.text)
                          return 'Not Match';
                        return null;
                      }
                  ),
                  SizedBox(height: 30.0),
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
                                    Navigator.pop(context, MaterialPageRoute(builder: (BuildContext context) {
                                      return LoginPage();
                                    }));
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
                  padding(30.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
