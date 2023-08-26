import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import '../components/components.dart';

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

  Widget formInputs() {
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
                UsernameField(
                  controller: _usernameInput,
                  hint: "Enter your Email",
                ),
                const SizedBox(height: 20),
                UsernameField(
                  controller: _passwordInput,
                  hint: "Enter your Password",
                ),
                const SizedBox(height: 20),
                button(
                  "Register",
                  () async {
                    final email = _usernameInput.text;
                    final password = _passwordInput.text;

                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    print(userCredential);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
