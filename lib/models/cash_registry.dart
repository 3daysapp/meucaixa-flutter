import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/models/expense.dart';

class CashRegistry {
  int note2 = 0;
  int note5 = 0;
  int note10 = 0;
  int note20 = 0;
  int note50 = 0;
  int note100 = 0;
  DateTime date = DateTime.now();
  double openValue = 0;
  double totalCreditCardMachine = 0;
  double totalExpenses = 0;
  double totalMoney = 0;
  double total = 0;
  List<CreditCardMachine> creditCardMachineList;
  List<Expense> expenseList;

  void _calculateExpenses() {
    totalExpenses = 0;
    for (Expense expense in expenseList) {
      totalExpenses += expense.value;
    }
  }

  void _calculateCreditCardMachines() {
    totalCreditCardMachine = 0;
    for (CreditCardMachine machine in creditCardMachineList) {
      totalCreditCardMachine += machine.controller.numberValue;
    }
  }

  void _calculateMoney() {
    totalMoney = 0;
    totalMoney += note2 * 2;
    totalMoney += note5 * 5;
    totalMoney += note10 * 10;
    totalMoney += note20 * 20;
    totalMoney += note50 * 50;
    totalMoney += note100 * 100;
  }

  void calculate() {
    _calculateExpenses();
    _calculateCreditCardMachines();
    _calculateMoney();
    total = 0;
    total += totalMoney;
    total += totalCreditCardMachine;
    total -= totalExpenses;
  }
}
