import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/screens/welcome_screen.dart';
import 'screens/caixa_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  Map<String, WidgetBuilder> routes = {
    WelcomeScreen.screenId: (context) => WelcomeScreen(),
    CaixaScreen.screenId: (context) => CaixaScreen(),
    LoginScreen.screenId: (context) => LoginScreen(),
    RegisterScreen.screenId: (context) => RegisterScreen(),
    CaixaScreen.screenId: (context) => CaixaScreen()
  };
  return routes;
}
