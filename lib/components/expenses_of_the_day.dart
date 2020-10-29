import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/models/expense.dart';

///
///
///
class ExpensesOfTheDay extends StatefulWidget {
  final List<Expense> expenseList;

  ///
  ///
  ///
  const ExpensesOfTheDay({Key key, this.expenseList}) : super(key: key);

  ///
  ///
  ///
  @override
  _ExpensesOfTheDayState createState() => _ExpensesOfTheDayState();
}

///
///
///
class _ExpensesOfTheDayState extends State<ExpensesOfTheDay> {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final Expense expense = widget.expenseList[index];
        return ListTile(
          title: Text(expense.value.toString()),
          subtitle: Text(expense.description),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
