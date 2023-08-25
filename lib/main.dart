import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_notes/components/input_fields.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

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
  final _usernameInput = TextEditingController();

  final _passwordInput = TextEditingController();

  @override
  void dispose() {
    _usernameInput.dispose();
    _passwordInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return formInputs();
          default:
            return const Text("Loading...");
        }
      },
    );
  }

  Padding formInputs() {
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
                usernameField(_usernameInput, "Username or Email"),
                const SizedBox(height: 20),
                passwordField(_passwordInput, "Password"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final email = _usernameInput.text;
                    final password = _passwordInput.text;

                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    print(userCredential);
                  },
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
}
