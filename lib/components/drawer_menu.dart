import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            onDetailsPressed: () {
              print('Clicou nos detalhes');
            },
            accountEmail: Text(_auth.currentUser.email),
            accountName: Text(_auth.currentUser.displayName),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: _auth.currentUser.photoURL != null
                  ? NetworkImage(_auth.currentUser.photoURL)
                  : AssetImage('images/no-user.png'),
              radius: 30,
            ),
          ),
          Text('teste'),
          Text('ABC'),
        ],
      ),
    );
  }
}
