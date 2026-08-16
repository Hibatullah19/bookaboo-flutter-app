import 'package:flutter/material.dart';

/// BookaBoo's palette — warm and playful, but deliberately deeper and less
/// saturated than a toy-box primary set so the UI reads as crafted.
abstract class AppColors {
  // Brand
  static const primary = Color(0xFF5B4BE0);
  static const primaryDeep = Color(0xFF2F2578);
  static const primarySoft = Color(0xFF8E82F0);

  // Accents
  static const coral = Color(0xFFFF7A6B);
  static const amber = Color(0xFFFFB443);
  static const teal = Color(0xFF22B8A6);
  static const sky = Color(0xFF4FB6F5);
  static const ocean = Color(0xFF0E86B8);
  static const rose = Color(0xFFF472B6);

  // Neutrals — light
  static const ink = Color(0xFF221E3B);
  static const inkMuted = Color(0xFF6B6786);
  static const inkFaint = Color(0xFF9C98B2);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceMuted = Color(0xFFF6F4FC);
  static const surfaceSunken = Color(0xFFEEEBF8);
  static const border = Color(0xFFE7E3F3);

  // Neutrals — dark
  static const darkSurface = Color(0xFF161334);
  static const darkSurfaceRaised = Color(0xFF201B47);
  static const darkSurfaceMuted = Color(0xFF2A2458);
  static const darkBorder = Color(0xFF352E66);
  static const darkInk = Color(0xFFF3F1FB);
  static const darkInkMuted = Color(0xFFACA6C9);

  // Semantic
  static const success = Color(0xFF2FA36B);
  static const danger = Color(0xFFE04B5B);

  // Gradients
  static const brandGradient = [primary, Color(0xFF8A5CF0)];
  static const duskGradient = [primaryDeep, rose];
  static const seaGradient = [ocean, sky];
  static const sunGradient = [Color(0xFFFF8A5B), amber];
}
