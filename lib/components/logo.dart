import 'package:flutter/material.dart';

///
///
///
class Logo extends StatelessWidget {
  final double size;

  ///
  ///
  ///
  const Logo({
    Key key,
    this.size = 200,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Hero(
        tag: 'logo',
        child: Image(
          image: AssetImage('images/meucaixa-logo.png'),
        ),
      ),
    );
  }
}
