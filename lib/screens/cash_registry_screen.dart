import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/expense_card.dart';
import 'package:meu_caixa_flutter/components/notacontainer.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/models/cash_registry.dart';
import 'package:meu_caixa_flutter/models/credit_card_machine.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:meu_caixa_flutter/screens/add_expense_screen.dart';
import 'package:meu_caixa_flutter/screens/day_result_screen.dart';

class CashRegistryScreen extends StatefulWidget {
  static String screenId = 'caixa_screen';
  final CashRegistry cashRegistry;

  CashRegistryScreen({@required this.cashRegistry});

  @override
  _CashRegistryScreenState createState() => _CashRegistryScreenState();
}

class _CashRegistryScreenState extends State<CashRegistryScreen> {
  void calculaTotal() {
    widget.cashRegistry.calculate();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      calculaTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                NotaContainer(
                  label: 'Notas de 2R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget.cashRegistry.note2++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget.cashRegistry.note2 > 0) {
                      setState(() {
                        widget.cashRegistry.note2--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget.cashRegistry.note2,
                ),
                NotaContainer(
                  label: 'Notas de 5R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget.cashRegistry.note5++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget.cashRegistry.note5 > 0) {
                      setState(() {
                        widget.cashRegistry.note5--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget.cashRegistry.note5,
                ),
              ],
            ),
            Row(
              children: [
                NotaContainer(
                  label: 'Notas de 10R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget.cashRegistry.note10++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget.cashRegistry.note10 > 0) {
                      setState(() {
                        widget.cashRegistry.note10--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget.cashRegistry.note10,
                ),
                NotaContainer(
                  label: 'Notas de 20R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget.cashRegistry.note20++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget.cashRegistry.note20 > 0) {
                      setState(() {
                        widget.cashRegistry.note20--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget.cashRegistry.note20,
                ),
              ],
            ),
            Row(
              children: [
                NotaContainer(
                  label: 'Notas de 50R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget.cashRegistry.note50++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget.cashRegistry.note50 > 0) {
                      setState(() {
                        widget.cashRegistry.note50--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget.cashRegistry.note50,
                ),
                NotaContainer(
                  label: 'Notas de 100R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget.cashRegistry.note100++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget.cashRegistry.note100 > 0) {
                      setState(() {
                        widget.cashRegistry.note100--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget.cashRegistry.note100,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total: ${widget.cashRegistry.totalMoney.toStringAsFixed(2)} R\$',
                style: kDefaultTotaisTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          DayResultScreen(cashRegistry: widget.cashRegistry),
                    ),
                  );
                },
                child: Text(
                  'Salvar Caixa',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FloatActionButtonAddDespesas extends StatelessWidget {
  final Function callback;
  FloatActionButtonAddDespesas({@required this.callback});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
        callback(expense);
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 45,
      ),
      backgroundColor: kRadicalRedColor,
      tooltip: 'Adiciona uma nova despesa ao caixa',
    );
  }
}
