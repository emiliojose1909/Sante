
import 'package:flutter/material.dart';

Future<void> msgbox(String mens, String titulo, BuildContext contexto) async {

  return showDialog<void>(
    context: contexto,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              
              Text(mens),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();              
            },
          ),
        ],
      );
    },
  );
}