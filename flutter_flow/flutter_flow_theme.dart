// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color lightOrange;
  late Color salmonPink;
  late Color blush;
  late Color raspberryRose;
  late Color chocolateCosmos;
  late Color carnationPink;
  late Color lemonChiffon;
  late Color nyanza;
  late Color uranianBlue;
  late Color mauve;
  late Color black;
  late Color oxfordBlue;
  late Color orangeWeb;
  late Color platinum;
  late Color white;
  late Color amber;
  late Color orangePantone;
  late Color rose;
  late Color blueViolet;
  late Color azure;
  late Color federalBlue;
  late Color marianBlue;
  late Color honoluluBlue;
  late Color blueGreen;
  late Color pacificCyan;
  late Color vividSkyBlue;
  late Color nonPhotoBlue;
  late Color nonPhotoBlue2;
  late Color lightCyan;
  late Color charcoal;
  late Color persianGreen;
  late Color saffron;
  late Color sandyBrown;
  late Color burntSienna;
  late Color timberwolf;
  late Color sage;
  late Color fernGreen;
  late Color hunterGreen;
  late Color brunswickGreen;
  late Color darkMossGreen;
  late Color pakistanGreen;
  late Color cornsilk;
  late Color earthYellow;
  late Color tigersEye;
  late Color spaceCadet;
  late Color coolGray;
  late Color antiflashWhite;
  late Color redPantone;
  late Color fireEngineRed;
  late Color paleAzure;
  late Color cyclamen;
  late Color atomicTangerine;
  late Color naplesYellow;
  late Color mindaro;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF4B39EF);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFE0E3E7);
  late Color primaryText = const Color(0xFF14181B);
  late Color secondaryText = const Color(0xFF57636C);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF249689);
  late Color warning = const Color(0xFFF9CF58);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFFFFFFF);

  late Color lightOrange = const Color(0xFFF9DBBD);
  late Color salmonPink = const Color(0xFFFFA5AB);
  late Color blush = const Color(0xFFDA627D);
  late Color raspberryRose = const Color(0xFFA53860);
  late Color chocolateCosmos = const Color(0xFF450920);
  late Color carnationPink = const Color(0xFFFF99C8);
  late Color lemonChiffon = const Color(0xFFFCF6BD);
  late Color nyanza = const Color(0xFFD0F4DE);
  late Color uranianBlue = const Color(0xFFA9DEF9);
  late Color mauve = const Color(0xFFE4C1F9);
  late Color black = const Color(0xFF000000);
  late Color oxfordBlue = const Color(0xFF14213D);
  late Color orangeWeb = const Color(0xFFFCA311);
  late Color platinum = const Color(0xFFE5E5E5);
  late Color white = const Color(0xFFFFFFFF);
  late Color amber = const Color(0xFFFFBE0B);
  late Color orangePantone = const Color(0xFFFB5607);
  late Color rose = const Color(0xFFFF006E);
  late Color blueViolet = const Color(0xFF8338EC);
  late Color azure = const Color(0xFF3A86FF);
  late Color federalBlue = const Color(0xFF03045E);
  late Color marianBlue = const Color(0xFF023E8A);
  late Color honoluluBlue = const Color(0xFF0077B6);
  late Color blueGreen = const Color(0xFF0096C7);
  late Color pacificCyan = const Color(0xFF00B4D8);
  late Color vividSkyBlue = const Color(0xFF48CAE4);
  late Color nonPhotoBlue = const Color(0xFF90E0EF);
  late Color nonPhotoBlue2 = const Color(0xFFADE8F4);
  late Color lightCyan = const Color(0xFFCAF0F8);
  late Color charcoal = const Color(0xFF264653);
  late Color persianGreen = const Color(0xFF2A9D8F);
  late Color saffron = const Color(0xFFE9C46A);
  late Color sandyBrown = const Color(0xFFF4A261);
  late Color burntSienna = const Color(0xFFE76F51);
  late Color timberwolf = const Color(0xFFDAD7CD);
  late Color sage = const Color(0xFFA3B18A);
  late Color fernGreen = const Color(0xFF588157);
  late Color hunterGreen = const Color(0xFF3A5A40);
  late Color brunswickGreen = const Color(0xFF344E41);
  late Color darkMossGreen = const Color(0xFF606C38);
  late Color pakistanGreen = const Color(0xFF283618);
  late Color cornsilk = const Color(0xFFFEFAE0);
  late Color earthYellow = const Color(0xFFDDA15E);
  late Color tigersEye = const Color(0xFFBC6C25);
  late Color spaceCadet = const Color(0xFF2B2D42);
  late Color coolGray = const Color(0xFF8D99AE);
  late Color antiflashWhite = const Color(0xFFEDF2F4);
  late Color redPantone = const Color(0xFFEF233C);
  late Color fireEngineRed = const Color(0xFFD90429);
  late Color paleAzure = const Color(0xFF70D6FF);
  late Color cyclamen = const Color(0xFFFF70A6);
  late Color atomicTangerine = const Color(0xFFFF9770);
  late Color naplesYellow = const Color(0xFFFFD670);
  late Color mindaro = const Color(0xFFE9FF70);
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Outfit';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 64.0,
      );
  String get displayMediumFamily => 'Outfit';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 44.0,
      );
  String get displaySmallFamily => 'Outfit';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 36.0,
      );
  String get headlineLargeFamily => 'Outfit';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Outfit';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 24.0,
      );
  String get headlineSmallFamily => 'Outfit';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
      );
  String get titleLargeFamily => 'Outfit';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Outfit',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleMediumFamily => 'Readex Pro';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Readex Pro',
        color: theme.info,
        fontWeight: FontWeight.normal,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Readex Pro';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Readex Pro',
        color: theme.info,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Readex Pro';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Readex Pro',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get labelMediumFamily => 'Readex Pro';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Readex Pro',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get labelSmallFamily => 'Readex Pro';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Readex Pro',
        color: theme.secondaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get bodyLargeFamily => 'Readex Pro';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Readex Pro',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Readex Pro';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Readex Pro',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Readex Pro';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Readex Pro',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF4B39EF);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFF262D34);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF95A1AC);
  late Color primaryBackground = const Color(0xFF1D2428);
  late Color secondaryBackground = const Color(0xFF14181B);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xB2262D34);
  late Color success = const Color(0xFF249689);
  late Color warning = const Color(0xFFF9CF58);
  late Color error = const Color(0xFFFF5963);
  late Color info = const Color(0xFFFFFFFF);

  late Color lightOrange = const Color(0xFFF9DBBD);
  late Color salmonPink = const Color(0xFFFFA5AB);
  late Color blush = const Color(0xFFDA627D);
  late Color raspberryRose = const Color(0xFFA53860);
  late Color chocolateCosmos = const Color(0xFF450920);
  late Color carnationPink = const Color(0xFFFF99C8);
  late Color lemonChiffon = const Color(0xFFFCF6BD);
  late Color nyanza = const Color(0xFFD0F4DE);
  late Color uranianBlue = const Color(0xFFA9DEF9);
  late Color mauve = const Color(0xFFE4C1F9);
  late Color black = const Color(0xFF000000);
  late Color oxfordBlue = const Color(0xFF14213D);
  late Color orangeWeb = const Color(0xFFFCA311);
  late Color platinum = const Color(0xFFE5E5E5);
  late Color white = const Color(0xFFFFFFFF);
  late Color amber = const Color(0xFFFFBE0B);
  late Color orangePantone = const Color(0xFFFB5607);
  late Color rose = const Color(0xFFFF006E);
  late Color blueViolet = const Color(0xFF8338EC);
  late Color azure = const Color(0xFF3A86FF);
  late Color federalBlue = const Color(0xFF03045E);
  late Color marianBlue = const Color(0xFF023E8A);
  late Color honoluluBlue = const Color(0xFF0077B6);
  late Color blueGreen = const Color(0xFF0096C7);
  late Color pacificCyan = const Color(0xFF00B4D8);
  late Color vividSkyBlue = const Color(0xFF48CAE4);
  late Color nonPhotoBlue = const Color(0xFF90E0EF);
  late Color nonPhotoBlue2 = const Color(0xFFADE8F4);
  late Color lightCyan = const Color(0xFFCAF0F8);
  late Color charcoal = const Color(0xFF264653);
  late Color persianGreen = const Color(0xFF2A9D8F);
  late Color saffron = const Color(0xFFE9C46A);
  late Color sandyBrown = const Color(0xFFF4A261);
  late Color burntSienna = const Color(0xFFE76F51);
  late Color timberwolf = const Color(0xFFDAD7CD);
  late Color sage = const Color(0xFFA3B18A);
  late Color fernGreen = const Color(0xFF588157);
  late Color hunterGreen = const Color(0xFF3A5A40);
  late Color brunswickGreen = const Color(0xFF344E41);
  late Color darkMossGreen = const Color(0xFF606C38);
  late Color pakistanGreen = const Color(0xFF283618);
  late Color cornsilk = const Color(0xFFFEFAE0);
  late Color earthYellow = const Color(0xFFDDA15E);
  late Color tigersEye = const Color(0xFFBC6C25);
  late Color spaceCadet = const Color(0xFF2B2D42);
  late Color coolGray = const Color(0xFF8D99AE);
  late Color antiflashWhite = const Color(0xFFEDF2F4);
  late Color redPantone = const Color(0xFFEF233C);
  late Color fireEngineRed = const Color(0xFFD90429);
  late Color paleAzure = const Color(0xFF70D6FF);
  late Color cyclamen = const Color(0xFFFF70A6);
  late Color atomicTangerine = const Color(0xFFFF9770);
  late Color naplesYellow = const Color(0xFFFFD670);
  late Color mindaro = const Color(0xFFE9FF70);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
