import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_mvp/core/theme.dart';
import 'package:flux_mvp/features/auth/view/screens/login_screen.dart';
import 'package:flux_mvp/features/auth/view/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flux_mvp/features/business_card/view/screens/create_cards.dart';
import 'package:flux_mvp/features/business_card/view/screens/template_screen.dart';
import 'package:flux_mvp/features/business_card/view/screens/view_saved_cards.dart';
import 'package:flux_mvp/features/nav_screens/view/screens/home_screen.dart';
import 'package:flux_mvp/features/nav_screens/view/screens/profile_screen.dart';
import 'package:flux_mvp/features/splashscreen/view/splash_screen.dart';
import 'package:flux_mvp/firebase_options.dart';
import 'package:toastification/toastification.dart';
final FirebaseCrashlytics crashlyticsInstance = FirebaseCrashlytics.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    await crashlyticsInstance.setCrashlyticsCollectionEnabled(false);
    
  } 
  FlutterError.onError = crashlyticsInstance.recordFlutterFatalError;
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  runApp(const ProviderScope(child: ToastificationWrapper(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          // Auth screens
          "/splash": (context) => const SplashScreen(),
          "/signup": (context) => const SignupScreen(),
          "/login": (context) => const LoginScreen(),
          // Navigation screens
          "/home": (context) => const HomeScreen(),
          "/profile": (context) => const ProfileScreen(),
          // Card screens
          '/template': (context) => const TemplateScreen(),
          '/create_cards': (context) => const CreateCards(),
          '/view_cards': (context) => const ViewSavedCards(),
        },
        initialRoute: "/splash",
        theme: AppTheme.darkThemeMode,
        debugShowCheckedModeBanner: false);
  }
}
