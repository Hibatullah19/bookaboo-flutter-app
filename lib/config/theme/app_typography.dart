import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Type scale: Baloo 2 for headings (rounded, warm) paired with Nunito for
/// body copy. Weight and color carry the hierarchy — body text is not all
/// bold-grey, which is what flattened the old scale.
abstract class AppTypography {
  static TextTheme build(TextTheme base, {required Color ink,
      required Color muted}) {
    TextStyle display(double size, {double spacing = -0.5}) =>
        GoogleFonts.baloo2(
          fontSize: size,
          fontWeight: FontWeight.w800,
          height: 1.12,
          letterSpacing: spacing,
          color: ink,
        );

    TextStyle heading(double size, FontWeight weight) => GoogleFonts.baloo2(
          fontSize: size,
          fontWeight: weight,
          height: 1.22,
          letterSpacing: -0.2,
          color: ink,
        );

    TextStyle body(double size, FontWeight weight, Color color,
            {double height = 1.55}) =>
        GoogleFonts.nunito(
          fontSize: size,
          fontWeight: weight,
          height: height,
          color: color,
        );

    return GoogleFonts.nunitoTextTheme(base).copyWith(
      displayLarge: display(42),
      displayMedium: display(34),
      displaySmall: display(28),
      headlineMedium: heading(24, FontWeight.w700),
      headlineSmall: heading(20, FontWeight.w700),
      titleLarge: heading(19, FontWeight.w700),
      titleMedium: heading(17, FontWeight.w600),
      titleSmall: body(14, FontWeight.w700, ink, height: 1.3),
      bodyLarge: body(16, FontWeight.w500, ink),
      bodyMedium: body(14, FontWeight.w500, muted),
      bodySmall: body(12.5, FontWeight.w500, muted, height: 1.45),
      labelLarge: GoogleFonts.baloo2(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
      labelMedium: body(13, FontWeight.w700, muted, height: 1.2),
      labelSmall: body(11.5, FontWeight.w700, muted, height: 1.2),
    );
  }
}
