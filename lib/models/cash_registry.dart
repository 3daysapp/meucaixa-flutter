import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/models/expense.dart';

///
///
///
class CashRegistry {
  int note2 = 0;
  int note5 = 0;
  int note10 = 0;
  int note20 = 0;
  int note50 = 0;
  int note100 = 0;
  DateTime date = DateTime.now();
  double openValue = 0;
  double total = 0;
  List<CreditCardMachine> creditCardMachineList;
  List<Expense> expenseList;

  ///
  ///
  ///
  double get totalExpenses => expenseList.fold<double>(0.0,
      (double previousValue, Expense expense) => previousValue + expense.value);

  ///
  ///
  ///
  double get totalCreditCardMachine => creditCardMachineList.fold<double>(
      0.0,
      (double previousValue, CreditCardMachine machine) =>
          previousValue + machine.controller.numberValue);

  ///
  ///
  ///
  double get totalMoney =>
      (note2 * 2.0) +
      (note5 * 5.0) +
      (note10 * 10.0) +
      (note20 * 20.0) +
      (note50 * 50.0) +
      (note100 * 100.0);

  ///
  ///
  ///
  void calculate() {
    total = 0;
    total += totalMoney;
    total += totalCreditCardMachine;
    total += openValue;
    total -= totalExpenses;
  }
}
