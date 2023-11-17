import 'package:flutter/material.dart';
import 'package:furmeetdev/presentation/widgets/profile_widget.dart';
import 'package:furmeetdev/presentation/screens/home.dart';
import 'package:furmeetdev/utils/functions.dart';
import 'package:furmeetdev/presentation/widgets/drawer.dart';
import 'package:furmeetdev/data/models/User.dart';

class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  @override
  Widget build (BuildContext context){
    double taille = MediaQuery.of(context).size.width * 0.5;

    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Modifier profil'),
        ),
        body: ListView(
          //https://github.com/JohannesMilke/user_profile_ii_example/blob/master/lib/model/user.dart => utilisation profil
          //padding: EdgeInsets.all(25.0),
          padding: EdgeInsets.symmetric(horizontal: 32),
          physics: BouncingScrollPhysics(),
          children: [
            padding(50.0),
            ProfileWidget(
              imagePath: 'lib/images/furmeet/logo_furmeet.png',
              isEdit: true,
              onClicked: () async {},
            ),
            padding(24.0),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pseudo',
              ),
              onChanged: (pseudo) {},
            ),
            padding(24.0),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              onChanged: (email) {},
            ),
            padding(20.0),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'A propos',
              ),
              maxLines: 5,
              onChanged: (about) {},
            ),
            padding(20.0),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return ProfileUpdate();
                  }));
                });
              },
              child: Text('Modifier',  style: TextStyle(color: Colors.white, fontSize: 20),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                fixedSize: const Size(100, 30),
                side: const BorderSide(
                    width: 2,
                    color: Colors.pink
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
