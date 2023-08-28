import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return formInputs();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text(
    //       "Registration",
    //       style: TextStyle(
    //         fontSize: 20,
    //         fontWeight: FontWeight.bold,
    //         color: Colors.purple,
    //       ),
    //     ),
    //     centerTitle: true,
    //     elevation: 0,
    //     backgroundColor: Colors.white,
    //   ),
    //   body: FutureBuilder(
    //     future: Firebase.initializeApp(
    //       options: DefaultFirebaseOptions.currentPlatform,
    //     ),
    //     builder: (context, snapshot) {
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.done:
    //           return formInputs();
    //         default:
    //           return const Text("Loading...");
    //       }
    //     },
    //   ),
    // );
  }

  void loginLogic() async {
    final email = _usernameInput.text;
    final password = _passwordInput.text;

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weal-password') {
        print("Weak Password");
      } else if (e.code == 'email-already-in-user') {
        print("Email is already taken");
      } else if (e.code == "invalid-email") {
        print("Invalid Email");
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
            // const SizedBox(height: 20),
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
                  loginLogic,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
