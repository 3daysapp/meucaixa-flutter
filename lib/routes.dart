import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/screens/add_expense_screen.dart';
import 'package:meu_caixa_flutter/screens/credit_cards_screen.dart';
import 'package:meu_caixa_flutter/screens/day_result_screen.dart';
import 'package:meu_caixa_flutter/screens/expenses_screen.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:meu_caixa_flutter/screens/welcome_screen.dart';
import 'screens/cash_registry_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  Map<String, WidgetBuilder> routes = {
    WelcomeScreen.screenId: (context) => WelcomeScreen(),
    CashRegistryScreen.screenId: (context) => CashRegistryScreen(),
    LoginScreen.screenId: (context) => LoginScreen(),
    RegisterScreen.screenId: (context) => RegisterScreen(),
    CashRegistryScreen.screenId: (context) => CashRegistryScreen(),
    AddExpenseScreen.screenId: (context) => AddExpenseScreen(),
    ExpenseScreen.screenId: (context) => ExpenseScreen(),
    MainScreen.screenId: (context) => MainScreen(),
    DayResultScreen.screenId: (context) => DayResultScreen(),
    CreditCardScreen.screenId: (context) => CreditCardScreen()
  };
  return routes;
}
