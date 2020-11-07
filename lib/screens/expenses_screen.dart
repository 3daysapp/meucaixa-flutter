import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/expense_card.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:meu_caixa_flutter/screens/add_expense_screen.dart';
import 'package:meu_caixa_flutter/screens/credit_cards_screen.dart';
import 'package:meu_caixa_flutter/screens/supplier_edit_screen.dart';

///
///
///
class ExpenseScreen extends StatefulWidget {
  static String screenId = 'ExpenseScreen';
  final CashRegistry cashRegistry;
  const ExpenseScreen({Key key, @required this.cashRegistry}) : super(key: key);

  ///
  ///
  ///
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

///
///
///
class _ExpenseScreenState extends State<ExpenseScreen> {
  List<Expense> expenseList = <Expense>[];

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Despesas do dia'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<SupplierEditScreen>(
                      builder: (BuildContext context) => SupplierEditScreen()),
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                // TODO - Revisar montagem da lista.
                child: ListView.builder(
                  itemCount: expenseList == null ? 0 : expenseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (expenseList[index] != null) {
                      return ExpenseCard(
                          expense: expenseList[index],
                          callback: () {
                            setState(() {
                              expenseList.removeAt(index);
                            });
                          });
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              FlatButton(
                onPressed: () async {
                  Expense expense = await showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) => SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: AddExpenseScreen(),
                    ),
                  );
                  setState(() {
                    expenseList.add(expense);
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Adicionar despesa'),
                    Icon(Icons.add),
                  ],
                ),
                color: Colors.redAccent,
              ),
              FlatButton(
                onPressed: () {
                  widget.cashRegistry.expenseList = expenseList;
                  Navigator.of(context).push(
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext context) =>
                          CreditCardScreen(cashRegistry: widget.cashRegistry),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Avançar'),
                    Icon(Icons.arrow_right_outlined),
                  ],
                ),
                color: Colors.blueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
