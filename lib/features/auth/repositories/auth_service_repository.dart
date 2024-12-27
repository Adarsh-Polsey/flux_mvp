import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flux_mvp/features/auth/models/user_model.dart';
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
  Future<UserModel> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      log("Value - $email");
      return (await getUserfromDb(email));
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
      rethrow;
    }
  }

//Sign up
  Future<UserModel> signup(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential;
      return (await addUsertoDb(
          UserModel(name: name, email: email, password: "")));
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthError(e);
      rethrow;
    }
  }

  // Add user to database
  Future<UserModel> addUsertoDb(UserModel user) async {
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final val = await db.collection('user').add(user.toMap());
      log("Value - $val");
      return user;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

// Get user from database
  Future<UserModel> getUserfromDb(String email) async {
    try {
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final val =
          await db.collection('user').where('email', isEqualTo: email).get();
      log("Value ${val.docs.first.data()}");
      return UserModel(name: "", email: email, password: "");
    } on FirebaseException catch (e) {
      throw Exception(e.message);
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
      notifier("Check your mail inbox for password updating link",
          status: "warning");
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
      errorMessage = 'An unknown error occurred: ${error.message}';
    }
    throw Exception(errorMessage);
  }
}
