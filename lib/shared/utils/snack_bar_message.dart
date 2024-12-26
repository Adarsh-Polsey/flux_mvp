import 'package:flutter/material.dart';

showSnackBarMessage(BuildContext context, Widget content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content:content));
}