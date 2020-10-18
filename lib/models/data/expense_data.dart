import 'dart:async';
import 'package:meu_caixa_flutter/models/expense.dart';

class ExpenseData {
  final _blocController = StreamController<ExpenseData>();
  Stream<ExpenseData> get expenseDataStream => _blocController.stream;
  List<Expense> expenseList = [];

  int get expenseCount {
    return expenseList.length;
  }

  void addExpenseToList(Expense expense) {
    expenseList.add(expense);
  }

  void removeExpenseFromList(Expense expense) {
    expenseList.remove(expense);
  }
}
