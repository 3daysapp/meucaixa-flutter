import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../contantes.dart';
import 'maismenosbotao.dart';

class NotaContainer extends StatefulWidget {
  final Function adicionaNotaFunc;
  final Function removeNotaFunc;
  final String label;
  int quantidade = 0;

  NotaContainer(
      {@required this.adicionaNotaFunc,
      @required this.removeNotaFunc,
      @required this.quantidade,
      @required this.label});

  @override
  _NotaContainerState createState() => _NotaContainerState();
}

class _NotaContainerState extends State<NotaContainer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.label,
              style: kDefaultValorLabelTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaisMenosBotao(
                  icon: Icons.remove,
                  onPressed: widget.removeNotaFunc,
                ),
                Text(
                  widget.quantidade.toString(),
                  style: kDefaultQuantidadeLabelTextStyle,
                ),
                MaisMenosBotao(
                  icon: Icons.add,
                  onPressed: widget.adicionaNotaFunc,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
