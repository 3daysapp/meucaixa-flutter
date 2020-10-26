import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/expense_card.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:meu_caixa_flutter/screens/add_expense_screen.dart';
import 'package:meu_caixa_flutter/screens/credit_cards_screen.dart';
import 'package:meu_caixa_flutter/screens/main_screen.dart';
import 'package:meu_caixa_flutter/utils/user_utils.dart';

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
        body: WillPopScope(
          onWillPop: () async => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Aviso"),
              content: Text(
                  "Tem certeza que deseja voltar? Ao voltar, o lançamento do caixa sera cancelado!"),
              actions: [
                RaisedButton(
                  child: Text('NÃO'),
                  color: Colors.green,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                RaisedButton(
                    child: Text('SIM'),
                    color: Colors.redAccent,
                    onPressed: () {
                      UserUtils.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, MainScreen.screenId, (route) => false);
                    }),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount:
                        expenseList.length == null ? 0 : expenseList.length,
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
      ),
    );
  }
}
