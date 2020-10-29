import 'package:flutter/material.dart';

///
///
///
class DisplayAlert {
  ///
  ///
  ///
  static Future<bool> show({
    @required BuildContext context,
    @required String message,
    String title = 'Atenção',
    String buttonText = 'OK',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                buttonText,
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  ///
  ///
  ///
  static Future<bool> yesNo({
    @required BuildContext context,
    String title = 'Atenção',
    @required String message,
    String affirmative = 'Sim',
    String negative = 'Não',
    bool marked = false,
  }) {
    Widget aff;
    Widget neg;

    if (marked) {
      aff = RaisedButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(
          affirmative,
        ),
        color: Theme.of(context).accentColor,
      );

      neg = FlatButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(negative),
      );
    } else {
      aff = FlatButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: Text(affirmative),
      );

      neg = RaisedButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: Text(
          negative,
        ),
        color: Theme.of(context).accentColor,
      );
    }

    return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[neg, aff],
          ),
        ) ??
        false;
  }
}
