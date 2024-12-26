import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_mvp/shared/utils/toast_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_service_repository.g.dart';

@riverpod
AuthServiceRepository authServiceRepository(Ref ref) {
  return AuthServiceRepository();
}

class AuthServiceRepository {
// instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
// Sign in
  Future<bool> login(String email, String pass) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
      bool verified = _auth.currentUser?.emailVerified ?? false;
      if (verified) {
        notifier("Welcome back!", status: "success");
      } else {
        notifier(
            "Provided mail hasn't been verified yet, check your mail for a verification link", status: "info");
        _auth.currentUser?.sendEmailVerification();
      }
      return verified;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
      return false;
    }
  }

//Sign up
  Future<bool> signup(String email, String pass) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);
      userCredential.user?.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
      throw Exception(e.code);
    }
  }

//Firebase Sign out
Future<void> fsignOut() async {
    await _auth.signOut();
  }

// Get token
  Future<String?> getId() async {
    try {
      String? token = await _auth.currentUser?.getIdToken();
      return token;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
      throw Exception(e.code);
    }
  }

// Email verification
  Future<bool?> get verification async {
    bool? verified = false;
    try {
      await _auth.currentUser?.reload();
      verified = _auth.currentUser?.emailVerified ?? false;
      return verified;
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
      return verified;
    }
  }

// Password Resetting
  void resetPassword(String mail) async {
    try {
      await _auth.sendPasswordResetEmail(email: mail);
      notifier("Check your mail inbox for password updating link",status: "warning");
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
    }
  }

// errors
  void handleFirebaseAuthError(FirebaseAuthException error) {
    String errorMessage = "Handling Unknown Exception";
    if (error.code == 'email-already-in-use') {
      errorMessage =
          'The email address has already been registered, try logging in.';
    } else if (error.code == 'channel-error') {
      errorMessage = "Invalid credentials";
    } else if (error.code == 'invalid-email') {
      errorMessage = 'The email address is invalid.';
    } else if (error.code == 'operation-not-allowed') {
      errorMessage =
          'Email/password sign-in is not allowed,please contact us for further measures.';
    } else if (error.code == 'wrong-password') {
      errorMessage = 'The password seems to be weak or incorrect.';
    } else if (error.code == 'network-request-failed') {
      errorMessage =
          'There is a problem with the internet connection or server communication.';
    } else if (error.code == 'user-not-found') {
      errorMessage =
          'The email address does not correspond to an existing account.';
    } else if (error.code == 'invalid-credential') {
      errorMessage =
          'Provided email and password does not match each other\nplease try again';
    } else if (error.code == 'user-disabled') {
      errorMessage = 'The user\'s account has been disabled.';
    } else if (error.code == 'too-many-requests') {
      errorMessage =
          'There have been too many failed sign-in attempts. Try again later.';
    } else {
      notifier('An unknown error occurred: ${error.code}', status: "error");
    }
    notifier(errorMessage,status: "error");
  }
}

