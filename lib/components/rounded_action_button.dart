import 'package:flutter/material.dart';

///
///
///
class RoundedActionButton extends StatelessWidget {
  final Color color;
  final String label;
  final Function callback;

  ///
  ///
  ///
  const RoundedActionButton({
    Key key,
    this.color,
    this.label,
    this.callback,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Material(
        color: color ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        elevation: 0,
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200,
          height: 42,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
