import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/components.dart';
import 'dart:developer' as dev show log;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    // return formInputs();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Login",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: formInputs()
        // FutureBuilder(
        //   future: Firebase.initializeApp(
        //     options: DefaultFirebaseOptions.currentPlatform,
        //   ),
        //   builder: (context, snapshot) {
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.done:
        //         return formInputs();
        //       default:
        //         return const Text("Loading...");
        //     }
        //   },
        // ),
        );
  }

  void loginLogic() async {
    final email = _usernameInput.text;
    final password = _passwordInput.text;

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      dev.log(userCredential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        dev.log("User Not Found");
      } else if (e.code == 'wrong-password') {
        dev.log("Password Incorrect");
      } else {
        dev.log(e.code);
      }
    }
  }

  Widget formInputs() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Icon(
              Icons.android,
              size: 140,
              color: Colors.purple.withOpacity(0.6),
            ),
            const SizedBox(height: 20),
            const Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please enter your email & password to login.",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: mainColor,
              ),
            ),
            const SizedBox(height: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                UsernameField(controller: _usernameInput, hint: "Email"),
                const SizedBox(height: 20),
                PasswordField(controller: _passwordInput, hint: "Password"),
                const SizedBox(height: 20),
                button(
                  "Login",
                  loginLogic,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User?",
                      style: TextStyle(
                          fontSize: 15, color: mainColor.withOpacity(0.8)),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/register',
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Register here!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.5,
                              color: mainColor),
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
