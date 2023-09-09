import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_notes/constants.dart';
import '../components/components.dart';
import 'dart:developer' as dev show log;

import '../components/error_dialog.dart';

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
    // return formInputs();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registration",
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
      body: formInputs(),
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
    const errorTitle = 'Registration Error';

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      dev.log(userCredential.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        dev.log("Weak Password");
        await showErrorDialog(
          context,
          errorTitle,
          "Password is very weak.\nPlease try a password of atleast 8 characters.",
        );
      } else if (e.code == 'email-already-in-use') {
        dev.log("Email is already taken");
        await showErrorDialog(
          context,
          errorTitle,
          "The provided Email is already taken.\nPlease try with a new one or Login.",
        );
      } else if (e.code == "invalid-email") {
        dev.log("Invalid Email");
        await showErrorDialog(
          context,
          errorTitle,
          "The provided Email is invalid.\nPlease provide a valid Email address.",
        );
      } else {
        await showErrorDialog(
          context,
          errorTitle,
          "Unknown Error Occured: ${e.code}",
        );
      }
    } catch (e) {
      await showErrorDialog(
        context,
        errorTitle,
        "Unknown Error\n${e.toString()}",
      );
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
              Icons.add_reaction_rounded,
              size: 140,
              color: Colors.purple.withOpacity(0.6),
            ),
            const SizedBox(height: 20),
            const Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please enter your email & password to register.",
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
                  loginLogic,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Registered?",
                      style: TextStyle(
                          fontSize: 15, color: mainColor.withOpacity(0.8)),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            loginRoute,
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Proceed to Login.",
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
