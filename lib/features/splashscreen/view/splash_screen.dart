import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flux_mvp/features/auth/view/screens/login_screen.dart';
import 'package:flux_mvp/features/nav_screens/view/bottom_nav_bar.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // logged in
              if (snapshot.hasData) {
                return const BottomNavBar();
              } else {
                return const LoginScreen();
              }
              // logged out
            }));
  }
}
