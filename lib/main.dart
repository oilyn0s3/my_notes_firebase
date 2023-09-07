import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/firebase_options.dart';
import 'package:my_notes/screens/login_screen.dart';
import 'package:my_notes/screens/registration_screen.dart';

import 'screens/notes_screen.dart';
import 'screens/verify_email_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/notes': (context) => const NotesScreen(),
      },
      initialRoute: '/',
      // home: const HomePage(), //RegistrationScreen()
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // return const LoginScreen();
            final user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              if (user.emailVerified) {
                //user.emailVerified
                // print("Email Verified");
                return const NotesScreen();
              } else {
                // print("Email is not verified");
                return const VerifiyEmailScreen();
              }
            } else {
              return const LoginScreen();
            }

          // return const Text("Done");
          default:
            // print('Loading...');
            return const CircularProgressIndicator();
        }
      },
    );
    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text(
    //       "My Notes",
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
    //   body:
    // );
  }
}
