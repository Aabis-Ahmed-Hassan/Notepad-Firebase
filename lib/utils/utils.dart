import 'package:flutter/material.dart';

class Utils {
  static showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }

  static changeFocus(
      FocusNode previousFocus, FocusNode nextFocus, BuildContext context) {
    previousFocus.unfocus();
    Focus.of(context).requestFocus(nextFocus);
  }
}
