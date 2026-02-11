import 'package:flutter/material.dart';

class ThemeController {
  ThemeController._();

  static final instance = ThemeController._();

  final ValueNotifier<ThemeMode> mode = ValueNotifier<ThemeMode>(ThemeMode.light);

  bool get isDark => mode.value == ThemeMode.dark;

  void toggle(bool darkOn) {
    mode.value = darkOn ? ThemeMode.dark : ThemeMode.light;
  }
}
