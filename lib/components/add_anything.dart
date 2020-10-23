import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/default_text_field.dart';

class AddAnything extends StatelessWidget {
  final List<Widget> childrens;

  AddAnything({@required this.childrens});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: childrens,
      ),
    );
  }
}
