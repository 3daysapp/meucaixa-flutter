import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/screens/configuration_screen.dart';
import 'package:meu_caixa_flutter/screens/login.dart';

class DrawerMenu extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 10,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
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
            ListTile(
              title: Text('Configurações'),
              leading: Icon(Icons.account_circle_outlined),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<ConfigurationScreen>(
                        builder: (BuildContext context) =>
                            ConfigurationScreen()));
              },
            ),
            ListTile(
              title: Text('Logoff'),
              leading: Icon(Icons.exit_to_app_outlined),
              onTap: () async {
                bool result = await DisplayAlert.yesNo(
                    context: context, message: 'Deseja mesmo desconectar-se?');
                if (result) {
                  await Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute<Login>(
                          builder: (BuildContext context) => Login(
                                logoff: true,
                              )),
                      (dynamic route) => false);
                }
              },
            )
          ],
        ));
  }
}
