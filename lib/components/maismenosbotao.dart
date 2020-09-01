import 'package:flutter/material.dart';

class MaisMenosBotao extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  MaisMenosBotao({@required this.onPressed, @required this.icon});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(
        icon,
        color: Colors.black,
      ),
      elevation: 6,
      shape: CircleBorder(),
      fillColor: icon == Icons.add ? Colors.green : Colors.red,
      constraints: BoxConstraints.tightFor(
        width: 36,
        height: 36,
      ),
    );
  }
}
