import 'package:flutter/material.dart';

///
///
///
class MenuItem extends StatelessWidget {
  final Function action;
  final String label;
  final IconData icon;
  final Color color;

  ///
  ///
  ///
  const MenuItem({
    Key key,
    this.label,
    this.action,
    this.icon,
    this.color,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RaisedButton(
        onPressed: action,
        color: color,
        padding: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40),
            Container(height: 5),
            Text(
              label,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
