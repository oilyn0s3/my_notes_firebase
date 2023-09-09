import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/components/components.dart';
import 'dart:developer' as dev show log;

import '../components/error_dialog.dart';
import '../constants.dart';

enum MenuAction { logout }

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Notes",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            PopupMenuButton(
              color: Colors.purple[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                // side: BorderSide(color: mainColor.withOpacity(0.5)),
              ),
              position: PopupMenuPosition.under,
              elevation: 2,
              icon: const Icon(
                Icons.more_vert,
                color: mainColor,
              ),
              // color: mainColor,
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogout = await showLogOutAlert(context);
                    dev.log(shouldLogout.toString());
                    if (shouldLogout) {
                      try {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute, (route) => false);
                      } catch (e) {
                        await showErrorDialog(
                          context,
                          'Logout Error',
                          "An error occured\n${e.toString()}",
                        );
                        // TODO
                      }
                    }
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text("Logout"),
                  )
                ];
              },
            ),
          ],
        ),
        body: const Text("My Notes"));
  }
}

Future<bool> showLogOutAlert(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Log out",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        content: Text(
          "Are you sure you want to log out?",
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: mainColor),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              "Log out",
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
