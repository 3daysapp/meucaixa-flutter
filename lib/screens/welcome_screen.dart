import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../contantes.dart';
import 'package:meu_caixa_flutter/components/rounded_action_button.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static String screenId = 'welcome_screen';
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 250,
                  width: 250,
                  child: Hero(
                    tag: 'logo',
                    child: Image(
                      image: AssetImage('images/meucaixa-logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Meu Caixa',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kCulturedColor,
                    fontSize: 45,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RoundedActionButton(
                  color: Colors.green,
                  callback: () {
                    Navigator.pushNamed(context, LoginScreen.screenId);
                  },
                  label: 'Entrar',
                ),
                RoundedActionButton(
                  color: kCarolinaColor,
                  callback: () {
                    Navigator.pushNamed(context, RegisterScreen.screenId);
                  },
                  label: 'Registrar-se',
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Container(
              color: Colors.white,
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
