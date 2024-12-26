import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flux_mvp/core/app_pallete.dart';
import 'package:toastification/toastification.dart';

// Showing toast
notifier(String message, {required String status}) {
  if (status == "success") {
    toastification.show(
        title: Text(message),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 5),
        style: ToastificationStyle.flatColored,
        foregroundColor: Colors.blue,
        backgroundColor: Pallete.backgroundColor,
        type: ToastificationType.success);
  } else if (status == "warning") {
    toastification.show(
        title: const Text("Warning!"),
        description: Text(message),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 5),
        style: ToastificationStyle.flatColored,
        foregroundColor: Colors.green,
        backgroundColor: Pallete.backgroundColor,
        type: ToastificationType.warning);
  } else if (status == "error") {
    toastification.show(
        title: const Text("Error!"),
        description: Text(message),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 5),
        style: ToastificationStyle.flatColored,
        primaryColor: Colors.red,
        foregroundColor: Colors.red,
        backgroundColor: Pallete.backgroundColor,
        type: ToastificationType.error);
  } else {
    toastification.show(
        title: const Text("Info!"),
        description: Text(message),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 5),
        style: ToastificationStyle.flatColored,
        foregroundColor: Colors.green,
        backgroundColor: Pallete.backgroundColor,
        type: ToastificationType.info);
  }
  log("🟩Notifier - $message");
}
