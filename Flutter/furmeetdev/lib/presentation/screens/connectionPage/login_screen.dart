import 'package:flutter/material.dart';
import 'package:furmeetdev/presentation/screens/connectionPage/login_success.dart';
import 'package:furmeetdev/presentation/screens/profile/profile_creation.dart';
import 'package:furmeetdev/presentation/widgets/drawer.dart';
import 'package:furmeetdev/utils/functions.dart';
import 'package:furmeetdev/presentation/viewmodels/UserViewModel.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isVisible = false;


  @override
  void initState() {
    super.initState();
    //checkLoggedIn(context);
  }

  Widget build (BuildContext context) {
    double taille = MediaQuery.of(context).size.width * 0.5;

    return GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Connexion'),
          ),
          drawer: MyDrawer(),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                padding(25),
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
                        image: AssetImage('assets/images/logo_furmeet.png')
                    ),
                  ),
                ),
                padding(20),
                const Text(
                  'Fur Meet',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding(50),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail'
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
                padding(10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isVisible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mot de passe',
                    suffixIcon: IconButton(
                      icon: Icon(_isVisible ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() {
                        _isVisible = !_isVisible;
                      }),
                    ),
                  ),
                ),
                padding(10),
                padding(15),
                ElevatedButton(
                  onPressed: () async {
                    // Vérifier les champs d'email et de mot de passe avant l'authentification
                    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                      // Authentifier l'utilisateur
                      bool isAuthenticated = await UserViewModel().authenticateUser(_emailController.text, _passwordController.text);
                      print('Is authenticated : $isAuthenticated');

                      if (isAuthenticated) {
                        // L'utilisateur est authentifié avec succès, redirigez-le vers la page de succès
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                          return LoginSuccess();
                        }));
                      } else {
                        // Afficher un message d'erreur si l'authentification échoue
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Erreur d\'authentification'),
                              content: Text('Veuillez vérifier vos informations d\'identification.'),
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
                  child: Text('Connexion',  style: TextStyle(color: Colors.white, fontSize: 25),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      fixedSize: const Size(300, 50),
                      side: const BorderSide(
                          width: 2,
                          color: Colors.pink
                      )
                  ),
                ),
                padding(10),
                ElevatedButton(
                  //Définir le onPressed pour la connexion
                  onPressed: (){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                        return RegistrationUser();
                      }));
                    });
                  },
                  child: Text(
                    'Inscription',
                    style: TextStyle(color: Colors.pink, fontSize: 23),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(300, 50),
                      side: const BorderSide(
                          width: 2,
                          color: Colors.pinkAccent
                      )
                  ),
                ),
                padding(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: (){
                          //Chemin vers mdp oublié
                        },
                        child: Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(color: Colors.pinkAccent, fontSize: 20),
                        )
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