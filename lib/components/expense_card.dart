import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final Function callback;
  ExpenseCard({@required this.expense, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expense.description.toUpperCase()),
                  Text('R\$ ${expense.value.toString()}'),
                ],
              ),
            ),
            IconButton(
              onPressed: callback,
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
