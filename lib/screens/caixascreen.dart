import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/notacontainer.dart';
import 'package:meu_caixa_flutter/contantes.dart';

class CaixaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Meu caixa',
          ),
        ),
      ),
      body: CaixaScreenBody(),
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
    total += widget._notas2 * 2;
    total += widget._notas5 * 5;
    total += widget._notas10 * 10;
    total += widget._notas20 * 20;
    total += widget._notas50 * 50;
    total += widget._notas100 * 100;
    total += caixa;
    widget._total = total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    if (value == null || value.length == 0) {
                      widget._caixa = '0.00';
                    } else {
                      widget._caixa = value.replaceAll(',', '.');
                    }
                    calculaTotal();
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kDefaultTextFieldStyle.copyWith(
                  labelText: 'Valor de abertura do caixa',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  suffix: Text('R\$'),
                ),
              ),
            ),
          ),
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
          )
        ],
      ),
    );
  }
}
