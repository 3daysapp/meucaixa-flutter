import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/app_version.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/menu_item.dart';
import 'package:meu_caixa_flutter/screens/login.dart';

///
///
///
class MainScreen extends StatefulWidget {
  static String screenId = 'mainScreen';

  ///
  ///
  ///
  @override
  _MainScreenState createState() => _MainScreenState();
}

///
///
///
class _MainScreenState extends State<MainScreen> {
  final User user = FirebaseAuth.instance.currentUser;

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meu Caixa'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /// Buttons
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      MenuItem(
                        icon: Icons.assignment_outlined,
                        label: 'Fechar Caixa',
                        color: Colors.green,
                        action: () {},
                      ),
                      MenuItem(
                        icon: Icons.analytics_outlined,
                        label: 'Histórico',
                        color: Colors.blueAccent,
                        action: () {},
                      ),
                      MenuItem(
                        icon: Icons.add_business_outlined,
                        label: 'Fornecedores',
                        color: Colors.teal,
                        action: () {},
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app_outlined,
                        label: 'Sair',
                        color: Colors.red,
                        action: _logout,
                      ),
                    ],
                  ),
                ),
              ),

              /// Version
              AppVersion(),
            ],
          ),
        ),
      ),
    );
  }

  ///
  ///
  ///
  void _logout() async {
    bool exit = await DisplayAlert.yesNo(
      context: context,
      message: 'Deseja realmente sair do app?',
    );

    if (exit) {
      await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<Login>(
          builder: (BuildContext context) => Login(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }
}
