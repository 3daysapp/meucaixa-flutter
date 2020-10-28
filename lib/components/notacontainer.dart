import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/maismenosbotao.dart';
import 'package:meu_caixa_flutter/contantes.dart';

///
///
///
class NotaContainer extends StatefulWidget {
  final Function adicionaNotaFunc;
  final Function removeNotaFunc;
  final Function onChanged;
  final Function clearQuantity;
  final String label;
  int quantidade = 0; // TODO - Verificar implementação.

  ///
  ///
  ///
  NotaContainer({
    Key key,
    @required this.adicionaNotaFunc,
    @required this.removeNotaFunc,
    @required this.quantidade,
    @required this.onChanged,
    @required this.clearQuantity,
    @required this.label,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _NotaContainerState createState() => _NotaContainerState();
}

///
///
///
class _NotaContainerState extends State<NotaContainer> {
  TextEditingController controller = TextEditingController();

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    controller.text = widget.quantidade.toString();
    return Expanded(
      child: Container(
        height: 120,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Theme.of(context).secondaryHeaderColor,
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
                  onLongPress: widget.clearQuantity,
                ),
                SizedBox(
                  width: 60,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: widget.onChanged,
                    controller: controller,
                    textAlign: TextAlign.center,
                    style: kDefaultQuantidadeLabelTextStyle,
                  ),
                ),
                // Text(
                //   widget.quantidade.toString(),
                //   style: kDefaultQuantidadeLabelTextStyle,
                // ),
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
