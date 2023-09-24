import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';
import '../constants.dart';

class VerifiyEmailScreen extends StatefulWidget {
  const VerifiyEmailScreen({super.key});

  @override
  State<VerifiyEmailScreen> createState() => _VerifiyEmailScreenState();
}

class _VerifiyEmailScreenState extends State<VerifiyEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Email Verification",
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Icon(
                    Icons.supervised_user_circle,
                    color: mainColor.withOpacity(0.6),
                    size: 140,
                  ),
                  const SizedBox(height: 60),
                  const Text(
                    "Verification email has been sent to your email address.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Did not recieve the verification email?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, color: mainColor.withOpacity(0.8)),
                  ),

                  Text(
                    "Click the button below to resend the email.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, color: mainColor.withOpacity(0.8)),
                  ),
                  const SizedBox(height: 20),
                  // TextButton(
                  //   onPressed: () async {
                  //     final user = FirebaseAuth.instance.currentUser;
                  //     await user?.sendEmailVerification();
                  //   },
                  //   child: const Text(
                  //     "Click here to resend the verification email!",
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 15,
                  //         color: mainColor),
                  //   ),
                  // ),
                  button(
                    "Resend Verification Email",
                    () async {
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 100),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    registerRoute,
                    (route) => false,
                  );
                },
                child: const Text(
                  "Go back to Registration Screen.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: mainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
