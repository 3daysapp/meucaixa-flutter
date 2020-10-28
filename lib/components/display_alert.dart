import 'package:flutter/material.dart';

// TODO - Verificar implementação.

///
///
///
void showAlertDialog({
  @required BuildContext context,
  String title,
  String message,
  @required List<Widget> actions,
}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: actions,
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
