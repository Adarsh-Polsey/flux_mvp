// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC_qjx4woTL6Cp1ca3qaGsmo495851qO9o',
    appId: '1:50764931284:web:2b9b2eeb01155779c8db41',
    messagingSenderId: '50764931284',
    projectId: 'fluxmvp-219d4',
    authDomain: 'fluxmvp-219d4.firebaseapp.com',
    storageBucket: 'fluxmvp-219d4.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdWOXJhalDtq4Qd0RrVC7LSKOtwaSOGb8',
    appId: '1:50764931284:android:bd62a7af55bae366c8db41',
    messagingSenderId: '50764931284',
    projectId: 'fluxmvp-219d4',
    storageBucket: 'fluxmvp-219d4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCX0FQcVwH3651WcMmlaOOXwsH9A4zaKs4',
    appId: '1:50764931284:ios:ee32f47204d45579c8db41',
    messagingSenderId: '50764931284',
    projectId: 'fluxmvp-219d4',
    storageBucket: 'fluxmvp-219d4.firebasestorage.app',
    iosBundleId: 'com.example.fluxMvp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCX0FQcVwH3651WcMmlaOOXwsH9A4zaKs4',
    appId: '1:50764931284:ios:ee32f47204d45579c8db41',
    messagingSenderId: '50764931284',
    projectId: 'fluxmvp-219d4',
    storageBucket: 'fluxmvp-219d4.firebasestorage.app',
    iosBundleId: 'com.example.fluxMvp',
  );

}