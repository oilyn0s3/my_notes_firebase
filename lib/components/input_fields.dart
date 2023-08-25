import 'package:flutter/material.dart';

InputDecoration inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(fontSize: 15, color: Colors.purple.withOpacity(0.7)),
    fillColor: Colors.purple.shade50,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 2,
        color: Colors.purple.withOpacity(0.4),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        width: 2,
        color: Colors.purple,
      ),
    ),
  );
}

TextField usernameField(
  TextEditingController controller,
  String hint,
) {
  return TextField(
    controller: controller,
    autocorrect: false,
    keyboardType: TextInputType.emailAddress,
    cursorOpacityAnimates: true,
    cursorColor: Colors.purple,
    decoration: inputDecoration(hint),
  );
}

TextField passwordField(
  TextEditingController controller,
  String hint,
) {
  return TextField(
    controller: controller,
    autocorrect: false,
    enableSuggestions: false,
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    cursorOpacityAnimates: true,
    cursorColor: Colors.purple,
    decoration: inputDecoration(hint),
  );
}
