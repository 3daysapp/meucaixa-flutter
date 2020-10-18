import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/components/expense_card.dart';
import 'package:meu_caixa_flutter/components/notacontainer.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/models/expense.dart';
import 'package:meu_caixa_flutter/screens/add_expense_screen.dart';

class CaixaScreen extends StatefulWidget {
  static String screenId = 'caixa_screen';

  @override
  _CaixaScreenState createState() => _CaixaScreenState();
}

class _CaixaScreenState extends State<CaixaScreen> {
  List<Expense> expenseList = [];
  int _notas2 = 0;
  int _notas5 = 0;
  int _notas10 = 0;
  int _notas20 = 0;
  int _notas50 = 0;
  int _notas100 = 0;
  String _caixa;
  String _total = '0.00';
  String _scielo = '0.00';
  String _stelo = '0.00';

  void calculaTotal() {
    double total = 0;
    double caixa = 0;
    if (_caixa != null) {
      caixa = double.parse(_caixa);
    }
    double scielo = scieloController.numberValue;
    double stelo = steloController.numberValue;
    print(_scielo);
    total += _notas2 * 2;
    total += _notas5 * 5;
    total += _notas10 * 10;
    total += _notas20 * 20;
    total += _notas50 * 50;
    total += _notas100 * 100;
    total += scielo;
    total += stelo;
    total += caixa;
    if (expenseList.isNotEmpty) {
      for (Expense expense in expenseList) {
        total -= expense.value;
      }
    }
    _total = total.toStringAsFixed(2);
  }

  var scieloController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var steloController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatActionButtonAddDespesas(
        callback: (expense) {
          setState(() {
            if (expense != null) {
              expenseList.add(expense);
            }
            calculaTotal();
          });
        },
      ),
      appBar: AppBar(
        title: Text(
          'Caixa',
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          return showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                  title: new Text('Aviso'),
                  content: new Text('Deseja realmente sair do app?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("Não"),
                    ),
                    SizedBox(height: 16),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("Sim"),
                    ),
                  ],
                ),
              ) ??
              false;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...expenseList
                  .map(
                    (expense) => ExpenseCard(
                      expense: expense,
                      callback: () {
                        setState(() {
                          expenseList.remove(expense);
                        });
                      },
                    ),
                  )
                  .toList(),
              DefaultTextField(
                  horizontalPadding: 10,
                  hintText: 'Cartão Scielo',
                  controller: scieloController,
                  callback: (value) {
                    setState(() {
                      _scielo = value;
                      calculaTotal();
                    });
                  }),
              DefaultTextField(
                  horizontalPadding: 10,
                  hintText: 'Cartão Stelo',
                  controller: steloController,
                  callback: (value) {
                    setState(() {
                      _stelo = value;
                      calculaTotal();
                    });
                  }),
              Row(
                children: [
                  NotaContainer(
                    label: 'Notas de 2R\$',
                    adicionaNotaFunc: () {
                      setState(() {
                        _notas2++;
                        calculaTotal();
                      });
                    },
                    removeNotaFunc: () {
                      if (_notas2 > 0) {
                        setState(() {
                          _notas2--;
                          calculaTotal();
                        });
                      }
                    },
                    quantidade: _notas2,
                  ),
                  NotaContainer(
                    label: 'Notas de 5R\$',
                    adicionaNotaFunc: () {
                      setState(() {
                        _notas5++;
                        calculaTotal();
                      });
                    },
                    removeNotaFunc: () {
                      if (_notas5 > 0) {
                        setState(() {
                          _notas5--;
                          calculaTotal();
                        });
                      }
                    },
                    quantidade: _notas5,
                  ),
                ],
              ),
              Row(
                children: [
                  NotaContainer(
                    label: 'Notas de 10R\$',
                    adicionaNotaFunc: () {
                      setState(() {
                        _notas10++;
                        calculaTotal();
                      });
                    },
                    removeNotaFunc: () {
                      if (_notas10 > 0) {
                        setState(() {
                          _notas10--;
                          calculaTotal();
                        });
                      }
                    },
                    quantidade: _notas10,
                  ),
                  NotaContainer(
                    label: 'Notas de 20R\$',
                    adicionaNotaFunc: () {
                      setState(() {
                        _notas20++;
                        calculaTotal();
                      });
                    },
                    removeNotaFunc: () {
                      if (_notas20 > 0) {
                        setState(() {
                          _notas20--;
                          calculaTotal();
                        });
                      }
                    },
                    quantidade: _notas20,
                  ),
                ],
              ),
              Row(
                children: [
                  NotaContainer(
                    label: 'Notas de 50R\$',
                    adicionaNotaFunc: () {
                      setState(() {
                        _notas50++;
                        calculaTotal();
                      });
                    },
                    removeNotaFunc: () {
                      if (_notas50 > 0) {
                        setState(() {
                          _notas50--;
                          calculaTotal();
                        });
                      }
                    },
                    quantidade: _notas50,
                  ),
                  NotaContainer(
                    label: 'Notas de 100R\$',
                    adicionaNotaFunc: () {
                      setState(() {
                        _notas100++;
                        calculaTotal();
                      });
                    },
                    removeNotaFunc: () {
                      if (_notas100 > 0) {
                        setState(() {
                          _notas100--;
                          calculaTotal();
                        });
                      }
                    },
                    quantidade: _notas100,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total: ${_total} R\$',
                  style: kDefaultTotaisTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: RaisedButton(
                  onPressed: () {},
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
