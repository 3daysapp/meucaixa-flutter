import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';
import 'package:meu_caixa_flutter/components/notacontainer.dart';
import 'package:meu_caixa_flutter/contantes.dart';
import 'package:meu_caixa_flutter/screens/add_expense_screen.dart';

class CaixaScreen extends StatelessWidget {
  static String screenId = 'caixa_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatActionButtonAddDespesas(),
      appBar: AppBar(
        title: Text(
          'Caixa',
        ),
      ),
      body: CaixaScreenBody(),
    );
  }
}

class FloatActionButtonAddDespesas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddExpenseScreen(),
                ));
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

class CaixaScreenBody extends StatefulWidget {
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

  @override
  _CaixaScreenBody createState() => _CaixaScreenBody();
}

class _CaixaScreenBody extends State<CaixaScreenBody> {
  void calculaTotal() {
    double total = 0;
    double caixa = 0;
    if (widget._caixa != null) {
      caixa = double.parse(widget._caixa);
    }
    double scielo = scieloController.numberValue;
    double stelo = steloController.numberValue;
    print(widget._scielo);
    total += widget._notas2 * 2;
    total += widget._notas5 * 5;
    total += widget._notas10 * 10;
    total += widget._notas20 * 20;
    total += widget._notas50 * 50;
    total += widget._notas100 * 100;
    total += scielo;
    total += stelo;
    total += caixa;
    widget._total = total.toStringAsFixed(2);
    print(widget._total);
  }

  var scieloController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  var steloController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  void decreaseNoteAmount(note) {
    setState(() {
      note--;
      calculaTotal();
    });
  }

  void increaseNoteAmount(note) {
    if (note > 0) {
      setState(() {
        note++;
        calculaTotal();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
            DefaultTextField(
                horizontalPadding: 10,
                hintText: 'Cartão Scielo',
                controller: scieloController,
                callback: (value) {
                  setState(() {
                    widget._scielo = value;
                    calculaTotal();
                  });
                }),
            DefaultTextField(
                horizontalPadding: 10,
                hintText: 'Cartão Stelo',
                controller: steloController,
                callback: (value) {
                  setState(() {
                    widget._stelo = value;
                    calculaTotal();
                  });
                }),
            Row(
              children: [
                NotaContainer(
                  label: 'Notas de 2R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget._notas2++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget._notas2 > 0) {
                      setState(() {
                        widget._notas2--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget._notas2,
                ),
                NotaContainer(
                  label: 'Notas de 5R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget._notas5++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget._notas5 > 0) {
                      setState(() {
                        widget._notas5--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget._notas5,
                ),
              ],
            ),
            Row(
              children: [
                NotaContainer(
                  label: 'Notas de 10R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget._notas10++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget._notas10 > 0) {
                      setState(() {
                        widget._notas10--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget._notas10,
                ),
                NotaContainer(
                  label: 'Notas de 20R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget._notas20++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget._notas20 > 0) {
                      setState(() {
                        widget._notas20--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget._notas20,
                ),
              ],
            ),
            Row(
              children: [
                NotaContainer(
                  label: 'Notas de 50R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget._notas50++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget._notas50 > 0) {
                      setState(() {
                        widget._notas50--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget._notas50,
                ),
                NotaContainer(
                  label: 'Notas de 100R\$',
                  adicionaNotaFunc: () {
                    setState(() {
                      widget._notas100++;
                      calculaTotal();
                    });
                  },
                  removeNotaFunc: () {
                    if (widget._notas100 > 0) {
                      setState(() {
                        widget._notas100--;
                        calculaTotal();
                      });
                    }
                  },
                  quantidade: widget._notas100,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total: ${widget._total} R\$',
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
    );
  }
}
