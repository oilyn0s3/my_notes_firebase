import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/components/components.dart';
import 'package:my_notes/firebase_options.dart';
import 'package:my_notes/screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), //RegistrationScreen()
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Notes",
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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return const LoginScreen();
            // final user = FirebaseAuth.instance.currentUser;

            // if (user?.emailVerified ?? false) {
            //   print("Email Verified");
            //   return const Text("Done...");
            // } else {
            //   print("Email is not verified");
            //   return const VerifiyEmailScreen();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const VerifiyEmailScreen(),
            //   ),
            // );

            default:
              print('Loading...');
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}

class VerifiyEmailScreen extends StatefulWidget {
  const VerifiyEmailScreen({super.key});

  @override
  State<VerifiyEmailScreen> createState() => _VerifiyEmailScreenState();
}

class _VerifiyEmailScreenState extends State<VerifiyEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 60),
          const Icon(
            Icons.supervised_user_circle,
            color: mainColor,
            size: 140,
          ),
          const SizedBox(height: 60),
          const Text(
            "Click the button below to send the Verification Email.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: mainColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 40),
          button(
            "Send Verification Email",
            () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
          ),
        ],
      ),
    );
  }
}
