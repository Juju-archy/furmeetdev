import 'package:flutter/material.dart';
import 'package:furmeetdev/presentation/screens/home.dart';
//import 'package:furmeet_test/page/meetup/meetup_display.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
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
            //selected: _selectedIndex == 0,
            onTap: () {
              // Update the state of the app
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return MyHomePage(title: 'Accueil',);
              }));
              //_onItemTapped(0);
              // Then close the drawer
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Meetup'),
            //selected: _selectedIndex == 1,
            onTap: () {
              /*Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return Meetup();
              }));*/
            },
          ),
          ListTile(
            title: const Text('Profil'),
            //selected: _selectedIndex == 2,
            onTap: () {
              // Update the state of the app
              //_onItemTapped(2);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

