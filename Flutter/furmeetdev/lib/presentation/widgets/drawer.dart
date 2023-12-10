import 'package:flutter/material.dart';
import 'package:furmeetdev/presentation/screens/home.dart';
import 'package:furmeetdev/presentation/screens/meetup/meetup_display.dart';
import 'package:furmeetdev/presentation/screens/profile/profile_list.dart';


class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(100, 78, 64, 100.0),
            ),
            child: Text('Fur Meet'),
          ),
          ListTile(
            title: const Text('Accueil'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return MyHomePage(title: 'Accueil',);
              }));
            },
          ),
          ListTile(
            title: const Text('Meetup'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return Meetup();
              }));
            },
          ),
          ListTile(
            title: const Text('Profil'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return Meetup();
              }));
            },
          ),
          ListTile(
            title: const Text('Mon Profil'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

