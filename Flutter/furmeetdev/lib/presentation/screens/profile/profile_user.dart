import 'package:flutter/material.dart';
import 'package:furmeetdev/utils/functions.dart';
import 'package:furmeetdev/presentation/widgets/drawer.dart';
//import 'package:furmeet_test/page/profil/profil_modify.dart';

class ProfilUSer extends StatefulWidget {
  @override
  _ProfilUserState createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUSer> {
  @override
  Widget build (BuildContext context){
    double taille = MediaQuery.of(context).size.width * 0.5;

    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Profile Archy'),
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textWithStyle('Archy', color: Colors.pinkAccent, fontSize: 30.0),
                        textWithStyle('29 ans, Toulouse', color: Colors.pinkAccent, fontSize: 20.0, fontStyle: FontStyle.italic),
                        ElevatedButton(
                          onPressed: (){
                            setState(() {
                              /*Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                return ProfileUpdate();
                              }));*/
                            });
                          },
                          child: Text('Modifier',  style: TextStyle(color: Colors.white, fontSize: 15),),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              fixedSize: const Size(150, 30),
                              side: const BorderSide(
                                  width: 2,
                                  color: Colors.pink
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: taille * 0.7,
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
                                image: AssetImage('lib/images/furmeet/logo_furmeet.png'),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              padding(25),
              //Info
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWithStyle('A propos', color: Colors.pinkAccent, fontSize: 30.0)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  //Faire un champ texte avec retour à la ligne automatique
                  Text(
                    'Furry baroudeuse\n'
                        'J\'aime la cuisine, les voitures, \nla couture, lire',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              padding(20),
              textWithStyle('Mes meetups', color: Colors.pinkAccent, fontSize: 30.0),
              Card(
                elevation: 10,
                shadowColor: Colors.pinkAccent,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){

                        },
                        child: Card(
                            elevation: 5,
                            shadowColor: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        textWithStyle('Archy', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        textWithStyle('Toulouse', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        textWithStyle('14/12/2023', color: Colors.pinkAccent),
                                        textWithStyle('17h', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: Card(
                            elevation: 5,
                            shadowColor: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        textWithStyle('Archy', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        textWithStyle('Toulouse', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        textWithStyle('14/12/2023', color: Colors.pinkAccent),
                                        textWithStyle('17h', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: Card(
                            elevation: 5,
                            shadowColor: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        textWithStyle('Archy', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        textWithStyle('Toulouse', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        textWithStyle('14/12/2023', color: Colors.pinkAccent),
                                        textWithStyle('17h', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: Card(
                            elevation: 5,
                            shadowColor: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        textWithStyle('Archy', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        textWithStyle('Toulouse', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        textWithStyle('14/12/2023', color: Colors.pinkAccent),
                                        textWithStyle('17h', color: Colors.pinkAccent)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}