import 'package:flutter/material.dart';
import 'app_brand_colors.dart';

class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light();

    const brand = AppBrandColors(
      bgTop: Color(0xFFFFF2FA),
      bgBottom: Color(0xFFF6ECFF),
      card: Color(0xFFFFFFFF),
      borderSoft: Color(0x14000000),
      accent: Color(0xFFA782FF),   // lila
      accent2: Color(0xFF51D7B6),  // mint
      textStrong: Color(0xFF111111),
      textSoft: Color(0xFF28C7A0),
    );

    return base.copyWith(
      useMaterial3: true,
      colorScheme: base.colorScheme.copyWith(
        primary: brand.accent,
        secondary: brand.accent2,
        surface: brand.card,
      ),
      scaffoldBackgroundColor: brand.bgBottom,
      textTheme: base.textTheme.copyWith(
        titleLarge: const TextStyle(fontWeight: FontWeight.w800),
        titleMedium: const TextStyle(fontWeight: FontWeight.w700),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extensions: const [brand],
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark();

    const brand = AppBrandColors(
      bgTop: Color(0xFF0B0B10),      // siyaha yakın
      bgBottom: Color(0xFF141420),   // koyu gri-mor
      card: Color(0xFF212131),       // card yüzeyi
      borderSoft: Color(0x26FFFFFF),
      accent: Color(0xFF5532B9),     // mor/lila vurgu
      accent2: Color(0xFF6EE7D2),    // mint (koyu temada da iyi)
      textStrong: Color(0xFFF6F4F4),
      textSoft: Color(0xFF6EE7D2),
    );

    return base.copyWith(
      useMaterial3: true,
      colorScheme: base.colorScheme.copyWith(
        primary: brand.accent,
        secondary: brand.accent2,
        surface: brand.card,
      ),
      scaffoldBackgroundColor: brand.bgBottom,
      textTheme: base.textTheme.copyWith(
        titleLarge: const TextStyle(fontWeight: FontWeight.w800),
        titleMedium: const TextStyle(fontWeight: FontWeight.w700),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extensions: const [brand],
    );
  }
}
