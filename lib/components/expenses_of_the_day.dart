import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/models/data/expense_data.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:provider/provider.dart';

class ExpensesOfTheDay extends StatefulWidget {
  @override
  _ExpensesOfTheDayState createState() => _ExpensesOfTheDayState();
}

class _ExpensesOfTheDayState extends State<ExpensesOfTheDay> {
  List<Expense> _expenses = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(builder: (context, expenseData, child) {
      return ListView.builder(itemBuilder: (context, index) {
        final expense = expenseData.expenseList[index];
        return ExpenseItemState(expense: expense);
      });
    });
  }
}

class ExpenseItemState extends StatelessWidget {
  final Expense expense;
  ExpenseItemState({@required this.expense});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.description),
      trailing: Row(
        children: [
          Text(expense.value.toString()),
          RaisedButton(
            onPressed: () {},
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
