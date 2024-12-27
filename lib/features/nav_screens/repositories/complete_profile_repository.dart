import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'complete_profile_repository.g.dart';

@riverpod
CompleteProfileRepository completeProfileRepository(Ref ref) {
  return CompleteProfileRepository();
}

class CompleteProfileRepository {
  Future<Map<String, dynamic>?> getProfileDetails() async {
    try {
      String docId = await getUserDocId();
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final val = await db.collection('user').doc(docId).get();
      log("Value - $val");
      return val.data();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Map<String, dynamic>?> completeProfile(
      Map<String, dynamic> details) async {
    try {
      String docId = await getUserDocId();
      final FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection('user').doc(docId).update(details);
      final val = await db.collection('user').doc(docId).get();
      return val.data();
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<String> getUserDocId() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String? email = auth.currentUser!.email;
      if (email == null) {
        throw Exception("User not logged in");
      }
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final val =
          await db.collection('user').where('email', isEqualTo: email).get();
      log("Document id - ${val.docs.first.id}");
      return val.docs.first.id.toString();
    } catch (e) {
      log("Error - $e");
      rethrow;
    }
  }
}
