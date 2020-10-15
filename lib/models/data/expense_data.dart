import 'package:flutter/cupertino.dart';
import 'package:meu_caixa_flutter/models/expense.dart';

class ExpenseData extends ChangeNotifier {
  List<Expense> expenseList = [];

  int get expenseCount {
    return expenseList.length;
  }

  void addExpenseToList(Expense expense) {
    expenseList.add(expense);
    notifyListeners();
  }

  void removeExpenseFromList(Expense expense) {
    expenseList.remove(expense);
    notifyListeners();
  }
}
