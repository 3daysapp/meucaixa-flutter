import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/expense_card.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:meu_caixa_flutter/screens/add_expense_screen.dart';
import 'package:meu_caixa_flutter/screens/credit_cards_screen.dart';

class ExpenseScreen extends StatefulWidget {
  static String screenId = 'ExpenseScreen';

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<Expense> expenseList = [];
  CashRegistry cashRegistry = CashRegistry();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Lançamento de despesas"),
          centerTitle: true,
        ),
        // TODO Implementar o canPop para impedir que o usuário saia sem querer do lançamento do caixa
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: expenseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpenseCard(
                        expense: expenseList[index],
                        callback: () {
                          setState(() {
                            expenseList.removeAt(index);
                          });
                        });
                  },
                ),
              ),
              FlatButton(
                onPressed: () async {
                  Expense expense = await showModalBottomSheet(
                    backgroundColor: Color(0x00FFFFFF),
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
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
                  children: [
                    Text('Adicionar despesa'),
                    Icon(Icons.add),
                  ],
                ),
                color: Colors.redAccent,
              ),
              FlatButton(
                onPressed: () {
                  cashRegistry.expenseList = expenseList;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CreditCardScreen(cashRegistry: cashRegistry),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Avançar"),
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
