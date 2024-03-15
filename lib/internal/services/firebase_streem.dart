import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/authorization/presentation/screens/auth_screen.dart';
import 'package:rick_and_morty/features/authorization/presentation/screens/verify_email_screen.dart';
import 'package:rick_and_morty/features/bottom_nav_bar.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Что-то пошло не так!',
              ),
            ),
          );
        } else if (snapshot.hasData) {
          log("${snapshot.hasData}");
          if (snapshot.data!.emailVerified) {
            return const BottomNavBarScreen();
          }
          return const VerifyEmailScreen();
        } else {
          return const AuthorizationScreen();
        }
      },
    );
  }
}
