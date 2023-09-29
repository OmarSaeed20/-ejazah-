// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

extension Context on BuildContext {
  void pop<T extends Object?>([T? result]) => Navigator.pop(this, result);

  Future<T?> navigateTo<T extends Object?>(Widget screen,
      {bool keepAllUntil = true}) =>
      Navigator.pushAndRemoveUntil(
          this,
          MaterialPageRoute(builder: (context) => screen),
              (route) => keepAllUntil);

  void pushReplacement(Widget screen) =>Navigator.pushReplacement(
    this,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );

  double get getHeight => MediaQueryData.fromWindow(ui.window).size.height;

  double get getWidth => MediaQueryData.fromWindow(ui.window).size.width;

  double get getTop => MediaQueryData.fromWindow(ui.window).padding.top;

  double get getBottom => MediaQueryData.fromWindow(ui.window).padding.bottom;

  TextTheme get textTheme => Theme.of(this).textTheme;
}


extension Validator on String {
  bool isValidEmail() {
    return RegExp(r'\S+@\S+\.\S+').hasMatch(this);
  }

  bool isValidPhoneNumber() {
    if (length == 11) {
      return RegExp(r'(010|011|012|015)[0-9]{8}').hasMatch(this);
    }
    return false;
  }

  bool isValidName() {
    return RegExp(
        r'^[ا-ي]+\s[ا-ي]+\s[ا-ي]+')
        .hasMatch(this);
  }
}
