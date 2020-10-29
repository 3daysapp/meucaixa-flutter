import 'package:flutter/material.dart';

///
///
///
class NormalCard extends StatelessWidget {
  final String title;
  final String trailing;
  final Color color;

  ///
  ///
  ///
  const NormalCard({
    Key key,
    @required this.title,
    @required this.trailing,
    @required this.color,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title),
              Text(trailing),
            ],
          ),
        ),
      ),
    );
  }
}
