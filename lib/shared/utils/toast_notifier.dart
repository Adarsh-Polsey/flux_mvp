
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

// Showing toast
notifier(String message, {required String status}) {
  if (status=="success") {
    toastification.show(
        title: const Text("Success!"),
        description: Text(message),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 5),
        style: ToastificationStyle.flatColored,
        type: ToastificationType.success);
  } else if (status=="warning") {
    toastification.show(
        title: const Text("Warning!"),
        description: Text(message),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 5),
        style: ToastificationStyle.flatColored,
        type: ToastificationType.warning);
  } else if (status=="error") {
    toastification.show(
        title: const Text("Error!"),
        description: Text(message),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 5),
        style: ToastificationStyle.flatColored,
        type: ToastificationType.error);
  } else {
    toastification.show(
        title: const Text("Info!"),
        description: Text(message),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 5),
        style: ToastificationStyle.flatColored,
        type: ToastificationType.info);
  }
  log("🟩Notifier - $message");
}