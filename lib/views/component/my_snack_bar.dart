import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16.0),
      backgroundColor: Colors.grey.shade900,
      content: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    ),
  );
}

// enum Snack