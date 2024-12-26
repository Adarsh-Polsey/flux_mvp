import 'dart:developer';

class AppFailure {
  final String message;
  AppFailure(this.message) {
    log("🔴Error - $message");
  }
}