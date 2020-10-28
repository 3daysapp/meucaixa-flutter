import 'package:flutter/material.dart';

///
///
///
class MaisMenosBotao extends StatelessWidget {
  final Function onPressed;
  final Function onLongPress;
  final IconData icon;

  ///
  ///
  ///
  const MaisMenosBotao({
    Key key,
    @required this.onPressed,
    @required this.icon,
    this.onLongPress,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Icon(
        icon,
        color: Colors.black,
      ),
      elevation: 6,
      shape: CircleBorder(),
      fillColor: icon == Icons.add ? Colors.green : Colors.redAccent,
      constraints: BoxConstraints.tightFor(
        width: 36,
        height: 36,
      ),
    );
  }
}
