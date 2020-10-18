import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/models/expense.dart';

class ExpensesOfTheDay extends StatefulWidget {
  final List<Expense> expenseList;
  ExpensesOfTheDay({this.expenseList});
  @override
  _ExpensesOfTheDayState createState() => _ExpensesOfTheDayState();
}

class _ExpensesOfTheDayState extends State<ExpensesOfTheDay> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      final expense = widget.expenseList[index];
      return ExpenseItemState(expense: expense);
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
