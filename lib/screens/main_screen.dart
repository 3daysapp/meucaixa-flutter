import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/drawer_menu.dart';

class MainScreen extends StatelessWidget {
  static String screenId = 'mainScreen';
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        drawer: DrawerMenu(),
        body: Container(
          child: Text(user.displayName),
        ),
      ),
    );
  }
}
