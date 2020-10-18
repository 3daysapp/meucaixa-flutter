import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Function action;
  final String label;
  final IconData icon;

  MenuItem({this.label, this.action, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FlatButton(
            onPressed: action,
            child: Row(
              children: [
                Icon(icon),
                SizedBox(
                  width: 10,
                ),
                Text(label),
              ],
            ),
          )
        ],
      ),
    );
  }
}
