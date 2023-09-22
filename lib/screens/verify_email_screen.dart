import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';

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
              "Verification email has been sent to your email address.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: mainColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Did not recieve the verification email?",
                  style: TextStyle(
                      fontSize: 15, color: mainColor.withOpacity(0.8)),
                ),
                TextButton(
                    onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser;
                      await user?.sendEmailVerification();
                    },
                    child: const Text(
                      "Click here to resend the verification email!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.5,
                          color: mainColor),
                    )),
              ],
            )
            // button(
            //   "Send Verification Email",
            //   () async {
            //     final user = FirebaseAuth.instance.currentUser;
            //     await user?.sendEmailVerification();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
