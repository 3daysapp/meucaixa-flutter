import 'package:flutter/material.dart';

class RoundedActionButton extends StatelessWidget {
  final Color color;
  final String label;
  final Function callback;

  RoundedActionButton({this.color, this.label, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Material(
        color: color == null ? Theme.of(context).primaryColor : color,
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
