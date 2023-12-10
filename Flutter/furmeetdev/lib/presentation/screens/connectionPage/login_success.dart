import 'package:flutter/material.dart';
import 'package:furmeetdev/presentation/screens/home.dart';
import 'package:furmeetdev/utils/functions.dart';
//import 'package:furmeet_test/page/profil/profil_user.dart';
import 'package:furmeetdev/presentation/widgets/drawer.dart';

class LoginSuccess extends StatefulWidget {
  @override
  _LoginSuccessState createState() => _LoginSuccessState();
}

class _LoginSuccessState extends State<LoginSuccess> {

  @override
  Widget build (BuildContext context) {
    double taille = MediaQuery.of(context).size.width * 0.5;

    return GestureDetector(
      //onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
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
                      image: AssetImage('lib/images/furmeet/logo_furmeet_icon.png')
                  ),
                ),
              ),
              padding(20.0),
              textWithStyle('Bienvenue Archy!', color: Colors.redAccent, fontSize: 40.0),
              Container(
                height: taille,
                width: taille,
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
                    ElevatedButton(
                      onPressed: (){
                        setState(() {
                          /*Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                            return ProfilUSer();
                          }));*/
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