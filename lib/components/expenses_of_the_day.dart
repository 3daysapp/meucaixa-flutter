import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/models/despesa.dart';

class ExpensesOfTheDay extends StatefulWidget {
  List<Expense> _expenses = [];
  @override
  _ExpensesOfTheDayState createState() => _ExpensesOfTheDayState();
}

class _ExpensesOfTheDayState extends State<ExpensesOfTheDay> {
  List<ListTile> getExpenseList() {
    Expense exp = new Expense();
    exp.descricao = 'Despesa de teste';
    exp.valor = 12.50;
    widget._expenses.add(exp);
    List<ListTile> expensesList = [];
    for (Expense expense in widget._expenses) {
      expensesList.add(
        ListTile(
          title: Text(expense.descricao),
          trailing: Column(
            children: [
              FlatButton(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  widget._expenses.remove(expense);
                },
              )
            ],
          ),
        ),
      );
    }
    return expensesList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getExpenseList(),
    );
  }
}
