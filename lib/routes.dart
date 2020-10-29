import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/screens/cash_registry_open_value_screen.dart';
import 'package:meu_caixa_flutter/screens/expenses_screen.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:meu_caixa_flutter/screens/supplier_screen.dart';
import 'package:meu_caixa_flutter/screens/welcome_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  Map<String, WidgetBuilder> routes = {
    WelcomeScreen.screenId: (BuildContext context) => WelcomeScreen(),
    LoginScreen.screenId: (BuildContext context) => LoginScreen(),
    RegisterScreen.screenId: (BuildContext context) => RegisterScreen(),
    ExpenseScreen.screenId: (BuildContext context) => ExpenseScreen(),
    MainScreen.screenId: (BuildContext context) => MainScreen(),
    ProviderScreen.screenId: (BuildContext context) => ProviderScreen(),
    CashRegistryOpenScreen.screenId: (BuildContext context) =>
        CashRegistryOpenScreen()
  };
  return routes;
}
