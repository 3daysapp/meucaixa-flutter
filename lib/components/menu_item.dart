import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
///
///
class MenuItem extends StatelessWidget {
  final Function action;
  final String label;
  final IconData icon;
  final Color color;
  final double height;

  ///
  ///
  ///
  const MenuItem({
    Key key,
    this.label,
    this.action,
    this.icon,
    this.color,
    this.height,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: RaisedButton(
        onPressed: action,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
            ),
            SizedBox(
              height: 5,
            ),
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
