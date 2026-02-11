import 'package:flutter/material.dart';

@immutable
class AppBrandColors extends ThemeExtension<AppBrandColors> {
  const AppBrandColors({
    required this.bgTop,
    required this.bgBottom,
    required this.card,
    required this.borderSoft,
    required this.accent,
    required this.accent2,
    required this.textStrong,
    required this.textSoft,
  });

  final Color bgTop;
  final Color bgBottom;
  final Color card;
  final Color borderSoft;

  final Color accent;   // ana vurgu (pembe/lila)
  final Color accent2;  // ikincil vurgu (mint vb.)
  final Color textStrong;
  final Color textSoft;

  @override
  AppBrandColors copyWith({
    Color? bgTop,
    Color? bgBottom,
    Color? card,
    Color? borderSoft,
    Color? accent,
    Color? accent2,
    Color? textStrong,
    Color? textSoft,
  }) {
    return AppBrandColors(
      bgTop: bgTop ?? this.bgTop,
      bgBottom: bgBottom ?? this.bgBottom,
      card: card ?? this.card,
      borderSoft: borderSoft ?? this.borderSoft,
      accent: accent ?? this.accent,
      accent2: accent2 ?? this.accent2,
      textStrong: textStrong ?? this.textStrong,
      textSoft: textSoft ?? this.textSoft,
    );
  }

  @override
  AppBrandColors lerp(ThemeExtension<AppBrandColors>? other, double t) {
    if (other is! AppBrandColors) return this;
    return AppBrandColors(
      bgTop: Color.lerp(bgTop, other.bgTop, t)!,
      bgBottom: Color.lerp(bgBottom, other.bgBottom, t)!,
      card: Color.lerp(card, other.card, t)!,
      borderSoft: Color.lerp(borderSoft, other.borderSoft, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accent2: Color.lerp(accent2, other.accent2, t)!,
      textStrong: Color.lerp(textStrong, other.textStrong, t)!,
      textSoft: Color.lerp(textSoft, other.textSoft, t)!,
    );
  }
}

extension BrandX on BuildContext {
  AppBrandColors get brand => Theme.of(this).extension<AppBrandColors>()!;
}
