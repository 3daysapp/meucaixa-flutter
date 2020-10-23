import 'package:flutter/material.dart';

class NormalCard extends StatelessWidget {
  final String title;
  final String trailing;
  final Color color;
  NormalCard({@required this.title, @required this.trailing, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        color: this.color,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(trailing),
            ],
          ),
        ),
      ),
    );
  }
}
