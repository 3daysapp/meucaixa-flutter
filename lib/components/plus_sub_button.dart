import 'package:flutter/material.dart';

///
///
///
enum PlusSubButtonType {
  PLUS,
  SUB,
}

///
///
///
class PlusSubButton extends StatelessWidget {
  final Function onPressed;
  final Function onLongPress;
  final PlusSubButtonType type;

  ///
  ///
  ///
  const PlusSubButton({
    Key key,
    @required this.onPressed,
    @required this.type,
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
      child: _icon(),
      elevation: 6,
      shape: CircleBorder(),
      fillColor: _color(),
      constraints: BoxConstraints.tightFor(
        width: 36,
        height: 36,
      ),
    );
  }

  ///
  ///
  ///
  Icon _icon() => type == PlusSubButtonType.PLUS
      ? Icon(Icons.add, color: Colors.black)
      : Icon(Icons.remove, color: Colors.black);

  ///
  ///
  ///
  Color _color() =>
      type == PlusSubButtonType.PLUS ? Colors.green : Colors.redAccent;
}
