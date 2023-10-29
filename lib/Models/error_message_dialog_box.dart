import 'package:flutter/material.dart';

class ErrorMessage {
  static void showAlertDialog(BuildContext context, String title, String content) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Retry"),
        ),
      ],
    );

    showDialog(context: context, builder: (context) {
      return alertDialog;
    });
  }
}