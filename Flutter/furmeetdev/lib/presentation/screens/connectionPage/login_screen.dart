/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furmeetdev/providers.dart';
import 'package:furmeetdev/presentation/screens/connectionPage/login_success.dart';
import 'package:furmeetdev/presentation/screens/profile/profile_creation.dart';
import 'package:furmeetdev/presentation/widgets/drawer.dart';
import 'package:furmeetdev/utils/functions.dart';
import 'package:furmeetdev/presentation/viewmodels/UserViewModel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';*/

import 'package:furmeetdev/presentation/screens/profile/profile_creation.dart';
import 'package:furmeetdev/utils/functions.dart';
import 'package:furmeetdev/data/providers/user_controller.dart';
import 'package:furmeetdev/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:furmeetdev/presentation/viewmodels/UserViewModel.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void showSnackbar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    double taille = MediaQuery.of(context).size.width * 0.5;

    return GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Connexion'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                padding(20),
                Container(
                  height: taille,
                  width: taille,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent,
                        blurRadius: 10,
                        offset: Offset(4, 9), // Shadow position
                      ),
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo_furmeet.png'),
                    ),
                  ),
                ),
                padding(40),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.people), //icon at head of input
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir un e-mail';
                    } else if (!RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Veuillez saisir un e-mail valide';
                    }
                    return null;
                  },
                ),
                padding(20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock), //icon at head of input
                    //prefixIcon: Icon(Icons.people), //you can use prefixIcon property too.
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: _togglePasswordView,
                      icon: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                      ),
                    ), //icon at tail of input
                  ),
                ),
                const SizedBox(height: 20),
                padding(20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {

                          // Vérifier les champs d'email et de mot de passe avant l'authentification
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            // Authentifier l'utilisateur
                            bool isAuthenticated = await UserViewModel().authenticateUser(
                                _emailController.text, _passwordController.text);


                            if (isAuthenticated) {
                              ref
                                  .read(userControllerProvider.notifier)
                                  .login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              )
                                  .then(
                                    (res) => {
                                  res.fold(
                                        (l) => {
                                      showSnackbar(context, l),
                                    },
                                        (r) => {
                                      Navigator.pushReplacementNamed(
                                          context, 'Accueil'),
                                    },
                                  ),
                                },
                              );
                            } else {
                              // Afficher un message d'erreur si l'authentification échoue
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Erreur d\'authentification'),
                                    content: Text(
                                        'Veuillez vérifier vos informations d\'identification.'),
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
                          } else {
                            // Afficher un message si les champs ne sont pas remplis
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Champs requis'),
                                  content: Text('Veuillez remplir tous les champs.'),
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
                        child: Text(
                          'Connexion',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          fixedSize: const Size(300, 50),
                          side: const BorderSide(width: 2, color: Colors.pink),
                        ),
                      ),
                    ),
                  ],
                ),
                padding(10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return RegistrationUser();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Inscription',
                    style: TextStyle(color: Colors.pink, fontSize: 23),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(300, 50),
                    side: const BorderSide(width: 2, color: Colors.pinkAccent),
                  ),
                ),
                padding(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        //Chemin vers mdp oublié
                      },
                      child: Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(color: Colors.pinkAccent, fontSize: 20),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }

}