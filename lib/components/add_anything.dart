import 'package:flutter/material.dart';

///
///
///
class AddAnything extends StatelessWidget {
  final List<Widget> children;

  ///
  ///
  ///
  AddAnything({@required this.children});

  ///
  ///
  ///
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
        children: children,
      ),
    );
  }
}
