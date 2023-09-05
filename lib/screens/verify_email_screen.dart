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
