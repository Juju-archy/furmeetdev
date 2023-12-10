import 'package:flutter/material.dart';
import 'package:furmeetdev/presentation/screens/connectionPage/login_screen.dart';
import 'package:furmeetdev/presentation/screens/home.dart';
import 'package:furmeetdev/presentation/viewmodels/UserViewModel.dart';
import 'package:furmeetdev/utils/functions.dart';
import 'package:furmeetdev/presentation/widgets/drawer.dart';
import 'package:furmeetdev/presentation/screens/profile/profile_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSuccess extends StatefulWidget {
  @override
  _LoginSuccessState createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {
  String pseudo = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pseudo = prefs.getString('pseudo') ?? '';
    });
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              padding(100.0),
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
              padding(20.0),
              textWithStyle('Bienvenue $pseudo!', color: Colors.redAccent, fontSize: 40.0),
              Container(
                child: Column(
                  //Profile / Accueil
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    padding(20.0),
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return MyHomePage(title: 'Archy',);
                          }));
                        });
                      },
                      child: textWithStyle('Accueil', fontSize: 30.0, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        elevation: 10.0,
                        backgroundColor: Colors.pinkAccent,
                        fixedSize: const Size(300, 50),
                        side: const BorderSide(
                            width: 2,
                            color: Colors.pinkAccent
                        ),
                      ),
                    ),
                    padding(20.0),
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return ProfilUSer();
                          }));
                        });
                      },
                      child: textWithStyle('Profile', fontSize: 30.0, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        elevation: 10.0,
                        backgroundColor: Colors.pinkAccent,
                        fixedSize: const Size(300, 50),
                        side: const BorderSide(
                            width: 2,
                            color: Colors.pinkAccent
                        ),
                      ),
                    ),
                    padding(50.0),
                    TextButton(
                      onPressed: () async {
                        await UserViewModel().logout();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                          return LoginPage();
                        }));
                      },
                      child: Text('Déconnexion'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}