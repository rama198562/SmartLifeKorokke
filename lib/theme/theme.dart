import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff476432),
      surfaceTint: Color(0xff4a6635),
      onPrimary: Color.fromARGB(255, 109, 81, 60),
      primaryContainer: Color(0xff5f7d49),
      onPrimaryContainer: Color(0xfff9ffed),
      secondary: Color.fromARGB(255, 226, 210, 191),
      onSecondary: Color.fromARGB(255, 109, 81, 60),
      secondaryContainer: Color(0xffd6e4c6),
      onSecondaryContainer: Color(0xff5a674f),
      tertiary: Color(0xff1b675a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff398072),
      onTertiaryContainer: Color(0xfff4fffa),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f5),
      onSurface: Color.fromARGB(255, 109, 81, 60),
      onSurfaceVariant: Color(0xff44483e),
      outline: Color(0xff74796d),
      outlineVariant: Color(0xffc4c8ba),
      shadow: Color.fromARGB(255, 109, 81, 60),
      scrim: Color.fromARGB(255, 109, 81, 60),
      inverseSurface: Color.fromARGB(255, 109, 81, 60),
      inversePrimary: Color(0xffafd194),
      primaryFixed: Color(0xffcbedae),
      onPrimaryFixed: Color.fromARGB(255, 109, 81, 60),
      primaryFixedDim: Color(0xffafd194),
      onPrimaryFixedVariant: Color(0xff334e1f),
      secondaryFixed: Color(0xffd9e7c9),
      onSecondaryFixed: Color.fromARGB(255, 109, 81, 60),
      secondaryFixedDim: Color(0xffbdcbae),
      onSecondaryFixedVariant: Color(0xff3e4a34),
      tertiaryFixed: Color(0xffa9f0df),
      onTertiaryFixed: .fromARGB(255, 109, 81, 60),
      tertiaryFixedDim: Color(0xff8dd4c3),
      onTertiaryFixedVariant: Color(0xff005045),
      surfaceDim: Color(0xffe2d8d3),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffcf2ed),
      surfaceContainer: Color(0xfff6ece7),
      surfaceContainerHigh: Color(0xfff0e6e1),
      surfaceContainerHighest: Color(0xffeae1dc),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff233d10),
      surfaceTint: Color(0xff4a6635),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff587542),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2e3a25),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff647158),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003e35),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff31796b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color.fromARGB(255, 109, 81, 60),
      onSurfaceVariant: Color(0xff33382e),
      outline: Color(0xff4f5449),
      outlineVariant: Color(0xff6a6f63),
      shadow: Color.fromARGB(255, 109, 81, 60),
      scrim: Color.fromARGB(255, 109, 81, 60),
      inverseSurface: Color.fromARGB(255, 109, 81, 60),
      inversePrimary: Color(0xffafd194),
      primaryFixed: Color(0xff587542),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff405c2c),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff647158),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4c5941),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff31796b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff0f6053),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcec5c0),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffcf2ed),
      surfaceContainer: Color(0xfff0e6e1),
      surfaceContainerHigh: Color(0xffe4dbd6),
      surfaceContainerHighest: Color(0xffd9d0cb),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff193206),
      surfaceTint: Color(0xff4a6635),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff355021),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff242f1b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff414d37),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00332b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff005347),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color.fromARGB(255, 109, 81, 60),
      onSurfaceVariant: Color.fromARGB(255, 109, 81, 60),
      outline: Color(0xff292e24),
      outlineVariant: Color(0xff464b40),
      shadow: Color.fromARGB(255, 109, 81, 60),
      scrim: Color.fromARGB(255, 109, 81, 60),
      inverseSurface: Color.fromARGB(255, 109, 81, 60),
      inversePrimary: Color(0xffafd194),
      primaryFixed: Color(0xff355021),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff1f390c),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff414d37),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff2b3621),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff005347),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003a31),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc0b7b3),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9efea),
      surfaceContainer: Color(0xffeae1dc),
      surfaceContainerHigh: Color(0xffdcd3ce),
      surfaceContainerHighest: Color(0xffcec5c0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffafd194),
      surfaceTint: Color(0xffafd194),
      onPrimary: Color(0xff1d370a),
      primaryContainer: Color(0xff7b9a62),
      onPrimaryContainer: Color(0xff132c02),
      secondary: Color(0xffbdcbae),
      onSecondary: Color(0xff28341f),
      secondaryContainer: Color(0xff414d36),
      onSecondaryContainer: Color(0xffafbda1),
      tertiary: Color(0xff8dd4c3),
      onTertiary: Color(0xff00382f),
      tertiaryContainer: Color(0xff579d8e),
      onTertiaryContainer: Color(0xff002c25),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color.fromARGB(255, 109, 81, 60),
      onSurface: Color(0xffeae1dc),
      onSurfaceVariant: Color(0xffc4c8ba),
      outline: Color(0xff8e9286),
      outlineVariant: Color(0xff44483e),
      shadow: Color.fromARGB(255, 109, 81, 60),
      scrim: Color.fromARGB(255, 109, 81, 60),
      inverseSurface: Color(0xffeae1dc),
      inversePrimary: Color(0xff4a6635),
      primaryFixed: Color(0xffcbedae),
      onPrimaryFixed: Color.fromARGB(255, 109, 81, 60),
      primaryFixedDim: Color(0xffafd194),
      onPrimaryFixedVariant: Color(0xff334e1f),
      secondaryFixed: Color(0xffd9e7c9),
      onSecondaryFixed: Color.fromARGB(255, 109, 81, 60),
      secondaryFixedDim: Color(0xffbdcbae),
      onSecondaryFixedVariant: Color(0xff3e4a34),
      tertiaryFixed: Color(0xffa9f0df),
      onTertiaryFixed: .fromARGB(255, 109, 81, 60),
      tertiaryFixedDim: Color(0xff8dd4c3),
      onTertiaryFixedVariant: Color(0xff005045),
      surfaceDim: Color.fromARGB(255, 109, 81, 60),
      surfaceBright: Color(0xff3d3835),
      surfaceContainerLowest: Color.fromARGB(255, 109, 81, 60),
      surfaceContainerLow: Color.fromARGB(255, 109, 81, 60),
      surfaceContainer: Color.fromARGB(255, 109, 81, 60),
      surfaceContainerHigh: Color(0xff2e2926),
      surfaceContainerHighest: Color(0xff393431),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc5e7a8),
      surfaceTint: Color(0xffafd194),
      onPrimary: Color(0xff122b02),
      primaryContainer: Color(0xff7b9a62),
      onPrimaryContainer: Color.fromARGB(255, 109, 81, 60),
      secondary: Color(0xffd3e1c3),
      onSecondary: Color(0xff1e2915),
      secondaryContainer: Color(0xff88957b),
      onSecondaryContainer: Color.fromARGB(255, 109, 81, 60),
      tertiary: Color(0xffa3ead9),
      onTertiary: Color(0xff002c24),
      tertiaryContainer: Color(0xff579d8e),
      onTertiaryContainer: Color.fromARGB(255, 109, 81, 60),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color.fromARGB(255, 109, 81, 60),
      surface: Color.fromARGB(255, 109, 81, 60),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdaded0),
      outline: Color(0xffafb4a6),
      outlineVariant: Color(0xff8d9285),
      shadow: Color.fromARGB(255, 109, 81, 60),
      scrim: Color.fromARGB(255, 109, 81, 60),
      inverseSurface: Color(0xffeae1dc),
      inversePrimary: Color(0xff344f20),
      primaryFixed: Color(0xffcbedae),
      onPrimaryFixed: Color.fromARGB(255, 109, 81, 60),
      primaryFixedDim: Color(0xffafd194),
      onPrimaryFixedVariant: Color(0xff233d10),
      secondaryFixed: Color(0xffd9e7c9),
      onSecondaryFixed: Color.fromARGB(255, 109, 81, 60),
      secondaryFixedDim: Color(0xffbdcbae),
      onSecondaryFixedVariant: Color(0xff2e3a25),
      tertiaryFixed: Color(0xffa9f0df),
      onTertiaryFixed: Color.fromARGB(255, 109, 81, 60),
      tertiaryFixedDim: Color(0xff8dd4c3),
      onTertiaryFixedVariant: Color(0xff003e35),
      surfaceDim: Color.fromARGB(255, 109, 81, 60),
      surfaceBright: Color(0xff494340),
      surfaceContainerLowest: Color.fromARGB(255, 109, 81, 60),
      surfaceContainerLow: Color.fromARGB(255, 109, 81, 60),
      surfaceContainer: Color(0xff2c2724),
      surfaceContainerHigh: Color(0xff37322f),
      surfaceContainerHighest: Color(0xff423d39),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd8fbbb),
      surfaceTint: Color(0xffafd194),
      onPrimary: Color.fromARGB(255, 109, 81, 60),
      primaryContainer: Color(0xffabcd90),
      onPrimaryContainer: Color.fromARGB(255, 109, 81, 60),
      secondary: Color(0xffe7f5d6),
      onSecondary: Color.fromARGB(255, 109, 81, 60),
      secondaryContainer: Color(0xffb9c7aa),
      onSecondaryContainer: Color.fromARGB(255, 109, 81, 60),
      tertiary: Color(0xffb6feec),
      onTertiary: Color.fromARGB(255, 109, 81, 60),
      tertiaryContainer: Color(0xff89d0bf),
      onTertiaryContainer: Color.fromARGB(255, 109, 81, 60),
      error: Color(0xffffece9),
      onError: Color.fromARGB(255, 109, 81, 60),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color.fromARGB(255, 109, 81, 60),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeef2e3),
      outlineVariant: Color(0xffc0c4b7),
      shadow: Color.fromARGB(255, 109, 81, 60),
      scrim: Color.fromARGB(255, 109, 81, 60),
      inverseSurface: Color(0xffeae1dc),
      inversePrimary: Color(0xff344f20),
      primaryFixed: Color(0xffcbedae),
      onPrimaryFixed: Color.fromARGB(255, 109, 81, 60),
      primaryFixedDim: Color(0xffafd194),
      onPrimaryFixedVariant: Color.fromARGB(255, 109, 81, 60),
      secondaryFixed: Color(0xffd9e7c9),
      onSecondaryFixed: Color.fromARGB(255, 109, 81, 60),
      secondaryFixedDim: Color(0xffbdcbae),
      onSecondaryFixedVariant: Color.fromARGB(255, 109, 81, 60),
      tertiaryFixed: Color(0xffa9f0df),
      onTertiaryFixed: Color.fromARGB(255, 109, 81, 60),
      tertiaryFixedDim: Color(0xff8dd4c3),
      onTertiaryFixedVariant: Color.fromARGB(255, 109, 81, 60),
      surfaceDim: Color.fromARGB(255, 109, 81, 60),
      surfaceBright: Color(0xff554f4c),
      surfaceContainerLowest: Color.fromARGB(255, 109, 81, 60),
      surfaceContainerLow: Color.fromARGB(255, 109, 81, 60),
      surfaceContainer: Color.fromARGB(255, 109, 81, 60),
      surfaceContainerHigh: Color(0xff403a37),
      surfaceContainerHighest: Color(0xff4b4642),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
