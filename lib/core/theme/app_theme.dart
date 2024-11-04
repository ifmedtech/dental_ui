import "package:flutter/material.dart";

class MaterialTheme {
  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4283849106),
      surfaceTint: Color(4283849106),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4292927743),
      onPrimaryContainer: Color(4279309387),
      secondary: Color(4284243314),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4292993273),
      onSecondaryContainer: Color(4279835180),
      tertiary: Color(4286075754),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294957293),
      onTertiaryContainer: Color(4281209125),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      background: Color(4294703359),
      onBackground: Color(4279966497),
      surface: Color(4294703359),
      onSurface: Color(4279966497),
      surfaceVariant: Color(4293190124),
      onSurfaceVariant: Color(4282795599),
      outline: Color(4286019200),
      outlineVariant: Color(4291282384),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348150),
      inverseOnSurface: Color(4294176759),
      inversePrimary: Color(4290757375),
      primaryFixed: Color(4292927743),
      onPrimaryFixed: Color(4279309387),
      primaryFixedDim: Color(4290757375),
      onPrimaryFixedVariant: Color(4282270072),
      secondaryFixed: Color(4292993273),
      onSecondaryFixed: Color(4279835180),
      secondaryFixedDim: Color(4291151069),
      onSecondaryFixedVariant: Color(4282664281),
      tertiaryFixed: Color(4294957293),
      onTertiaryFixed: Color(4281209125),
      tertiaryFixedDim: Color(4293442004),
      onTertiaryFixedVariant: Color(4284431442),
      surfaceDim: Color(4292663776),
      surfaceBright: Color(4294703359),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294308602),
      surfaceContainer: Color(4293979380),
      surfaceContainerHigh: Color(4293584879),
      surfaceContainerHighest: Color(4293190121),
    );
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4291869950),
      surfaceTint: Color(4291869951),
      onPrimary: Color(4281867890),
      primaryContainer: Color(4283381643),
      onPrimaryContainer: Color(4293582335),
      secondary: Color(4291609308),
      onSecondary: Color(4281544001),
      secondaryContainer: Color(4283057240),
      onSecondaryContainer: Color(4293451512),
      tertiary: Color(4293900488),
      onTertiary: Color(4282983730),
      tertiaryContainer: Color(4284693320),
      onTertiaryContainer: Color(4294957284),
      error: Color(4294097077),
      onError: Color(4284486672),
      errorContainer: Color(4287372568),
      onErrorContainer: Color(4294565596),
      background: Color(4279505432),
      onBackground: Color(4293320937),
      surface: Color(4279505432),
      onSurface: Color(4293320937),
      surfaceVariant: Color(4282991951),
      onSurfaceVariant: Color(4291478736),
      outline: Color(4287860633),
      outlineVariant: Color(4282991951),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293320937),
      inverseOnSurface: Color(4281478965),
      inversePrimary: Color(4284960932),
      primaryFixed: Color(4293582335),
      onPrimaryFixed: Color(4280352861),
      primaryFixedDim: Color(4291869951),
      onPrimaryFixedVariant: Color(4283381643),
      secondaryFixed: Color(4293451512),
      onSecondaryFixed: Color(4280097067),
      secondaryFixedDim: Color(4291609308),
      onSecondaryFixedVariant: Color(4283057240),
      tertiaryFixed: Color(4294957284),
      onTertiaryFixed: Color(4281405725),
      tertiaryFixedDim: Color(4293900488),
      onTertiaryFixedVariant: Color(4284693320),
      surfaceDim: Color(4279505432),
      surfaceBright: Color(4282071102),
      surfaceContainerLowest: Color(4279176467),
      surfaceContainerLow: Color(4280097568),
      surfaceContainer: Color(4280360742),
      surfaceContainerHigh: Color(4281018672),
      surfaceContainerHighest: Color(4281742395),
    );
  }

  static ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: const TextTheme().apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

// List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}
//
// class ExtendedColor {
//   final Color seed, value;
//   final ColorFamily light;
//   final ColorFamily lightHighContrast;
//   final ColorFamily lightMediumContrast;
//   final ColorFamily dark;
//   final ColorFamily darkHighContrast;
//   final ColorFamily darkMediumContrast;
//
//   const ExtendedColor({
//     required this.seed,
//     required this.value,
//     required this.light,
//     required this.lightHighContrast,
//     required this.lightMediumContrast,
//     required this.dark,
//     required this.darkHighContrast,
//     required this.darkMediumContrast,
//   });
// }
//
// class ColorFamily {
//   const ColorFamily({
//     required this.color,
//     required this.onColor,
//     required this.colorContainer,
//     required this.onColorContainer,
//   });
//
//   final Color color;
//   final Color onColor;
//   final Color colorContainer;
//   final Color onColorContainer;
// }
