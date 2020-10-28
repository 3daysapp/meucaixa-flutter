import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/screens/credit_cards_screen.dart';
import 'package:meu_caixa_flutter/screens/day_result_screen.dart';
import 'package:meu_caixa_flutter/screens/expenses_screen.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:meu_caixa_flutter/screens/provider_screen.dart';
import 'package:meu_caixa_flutter/screens/welcome_screen.dart';
import 'screens/cash_registry_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  Map<String, WidgetBuilder> routes = {
    WelcomeScreen.screenId: (context) => WelcomeScreen(),
    // TODO - Atenção
    CashRegistryScreen.screenId: (context) => CashRegistryScreen(),
    LoginScreen.screenId: (context) => LoginScreen(),
    RegisterScreen.screenId: (context) => RegisterScreen(),
    // TODO - Atenção
    CashRegistryScreen.screenId: (context) => CashRegistryScreen(),
    ExpenseScreen.screenId: (context) => ExpenseScreen(),
    MainScreen.screenId: (context) => MainScreen(),
    // TODO - Atenção
    DayResultScreen.screenId: (context) => DayResultScreen(),
    // TODO - Atenção
    CreditCardScreen.screenId: (context) => CreditCardScreen(),
    ProviderScreen.screenId: (context) => ProviderScreen()
  };
  return routes;
}
