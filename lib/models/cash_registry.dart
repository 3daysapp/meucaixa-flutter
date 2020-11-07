import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/models/expense.dart';

///
///
///
class CashRegistry {
  String id;
  int note2 = 0;
  int note5 = 0;
  int note10 = 0;
  int note20 = 0;
  int note50 = 0;
  int note100 = 0;
  /// TODO - E a nota de R$ 200
  DateTime date = DateTime.now();
  double totalCreditCardMachine;
  double totalExpenses;
  double totalMoney;
  double openValue = 0;
  double total = 0;
  List<CreditCardMachine> creditCardMachineList;
  List<Expense> expenseList;

  ///
  ///
  ///
  CashRegistry();

  ///
  ///
  ///
  CashRegistry.fromMap(String id, Map<String, dynamic> map)
      : id = id,
        date = map['date'],
        openValue = map['openValue'],
        totalCreditCardMachine = map['totalCreditCardMachine'],
        totalExpenses = map['totalExpenses'],
        totalMoney = map['totalMoney'],
        total = map['total'];

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['date'] = date;
    map['openValue'] = openValue;
    map['totalCreditCardMachine'] = getTotalCreditCardMachine;
    map['totalExpenses'] = getTotalExpenses;
    map['totalMoney'] = getTotalMoney;
    map['total'] = total;
    return map;
  }

  ///
  ///
  ///
  double get getTotalExpenses => expenseList.fold<double>(0.0,
      (double previousValue, Expense expense) => previousValue + expense.value);

  ///
  ///
  ///
  double get getTotalCreditCardMachine => creditCardMachineList.fold<double>(
      0.0,
      (double previousValue, CreditCardMachine machine) =>
          previousValue + machine.value);

  ///
  ///
  ///
  double get getTotalMoney =>
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
    total += getTotalMoney;
    total += getTotalCreditCardMachine;
    total += openValue;
    total -= getTotalExpenses;
  }
}
