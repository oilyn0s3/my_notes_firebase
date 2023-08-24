import 'package:flutter/material.dart';
import 'Fire';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: RegistrationScreen(),
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _userIdInput = TextEditingController();

  final _passwordInput = TextEditingController();

  @override
  void dispose() {
    _userIdInput.dispose();
    _passwordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            const Icon(
              Icons.android,
              size: 140,
              color: Colors.purple,
            ),
            // const SizedBox(height: 10),
            const Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                inputField(_userIdInput, "Username or Email"),
                const SizedBox(height: 20),
                inputField(_passwordInput, "Password"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.all(20),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  TextField inputField(
    TextEditingController controller,
    String hint,
  ) {
    return TextField(
      controller: controller,
      cursorColor: Colors.purple,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            TextStyle(fontSize: 15, color: Colors.purple.withOpacity(0.7)),
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
      ),
    );
  }
}
