import 'package:flutter/material.dart';

import 'components.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String alertTitle,
  String alertMessage,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(top: 20),
        // actionsPadding: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          alertTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mainColor.withOpacity(0.8),
          ),
        ),
        content: Text(
          alertMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Okay",
              style: TextStyle(
                color: mainColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
    },
  );
}
