import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/screens/welcome_screen.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: getRoutes(context),
      initialRoute: WelcomeScreen.screenId,
      theme: ThemeData.dark(),
    );
  }
}
