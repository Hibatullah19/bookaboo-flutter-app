import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/theme/theme.dart';

/// Single entry point for bundled artwork so sizing, clipping and the
/// loading placeholder behave the same everywhere.
class AppImage extends StatelessWidget {
  const AppImage._({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.radius = 0,
    this.alignment = Alignment.center,
  });

  /// Book / category artwork — fills its box and is corner-clipped.
  const AppImage.cover(
    String asset, {
    Key? key,
    double? width,
    double? height,
    double radius = AppRadius.lg,
    Alignment alignment = Alignment.center,
  }) : this._(
          key: key,
          asset: asset,
          width: width,
          height: height,
          radius: radius,
          alignment: alignment,
        );

  /// Illustrations — fit inside their box, never cropped.
  const AppImage.illustration(
    String asset, {
    Key? key,
    double? width,
    double? height,
  }) : this._(
          key: key,
          asset: asset,
          width: width,
          height: height,
          fit: BoxFit.contain,
        );

  final String asset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double radius;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final image = SvgPicture.asset(
      asset,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      // Must not be SizedBox.expand: the placeholder is also rendered in
      // unbounded parents (a Column child), where "as big as possible"
      // throws. A bare ColoredBox fills a bounded parent and collapses
      // harmlessly in an unbounded one.
      placeholderBuilder: (_) => SizedBox(
        width: width,
        height: height,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
      ),
    );
    if (radius == 0) return image;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: image,
    );
  }
}

/// Tiles a small SVG pattern across its parent at low opacity. Used to give
/// flat gradient headers a bit of texture.
class AppPatternOverlay extends StatelessWidget {
  const AppPatternOverlay({
    super.key,
    required this.asset,
    this.opacity = 0.18,
    this.tile = 120,
  });

  final String asset;
  final double opacity;
  final double tile;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cols = (constraints.maxWidth / tile).ceil();
            final rows = (constraints.maxHeight / tile).ceil();
            return Wrap(
              children: List.generate(
                cols * rows,
                (_) => SvgPicture.asset(asset, width: tile, height: tile),
              ),
            );
          },
        ),
      ),
    );
  }
}
