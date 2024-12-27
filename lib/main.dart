import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_mvp/core/theme.dart';
import 'package:flux_mvp/features/auth/view/screens/login_screen.dart';
import 'package:flux_mvp/features/auth/view/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flux_mvp/features/nav_screens/view/screens/home_screen.dart';
import 'package:flux_mvp/features/nav_screens/view/screens/profile_screen.dart';
import 'package:flux_mvp/features/splashscreen/view/splash_screen.dart';
import 'package:flux_mvp/firebase_options.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: ToastificationWrapper(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "/splash": (context) => const SplashScreen(),
          "/signup": (context) => const SignupScreen(),
          "/login": (context) => const LoginScreen(),
          "/home": (context) => const HomeScreen(),
          "/profile": (context) => const ProfileScreen(),
        },
        initialRoute: "/splash",
        theme: AppTheme.darkThemeMode,
        debugShowCheckedModeBanner: false);
  }
}
