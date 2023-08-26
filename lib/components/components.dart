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

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const UsernameField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      cursorOpacityAnimates: true,
      cursorColor: Colors.purple,
      decoration: inputDecoration(hint),
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const PasswordField({
    super.key,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
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
}

ElevatedButton button(String label, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.purple,
      padding: const EdgeInsets.all(20),
      elevation: 0,
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 16),
    ),
  );
}
