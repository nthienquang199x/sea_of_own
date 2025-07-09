import 'package:flutter/material.dart';

class AppColorScheme {
  final Color primary;
  final Color appBarBackground;
  final Color scaffoldBackgroundColor;
  final Color textBtnColor;
  final Color cardColor;
  final Color cardSurfaceTintColor;
  final Color cardShadowColor;
  final Color textColor;
  final Color dialogBackgroundColor;
  final Color background;
  final Color foreground;
  final Color muted;
  final Color mutedForeground;
  final Color primaryColor;
  final Color primaryForeground;
  final Color iconActive;
  final Color iconInactive;
  final Color separator1;
  final Color separator2;
  final Color secondary;
  final Color secondaryForeground;
  final Color tab;
  final Color menuIconBg;
  final Color card;
  final Color cardForeground;
  final Color destructive;

  const AppColorScheme({
    required this.primary,
    required this.appBarBackground,
    required this.scaffoldBackgroundColor,
    required this.textBtnColor,
    required this.cardColor,
    required this.cardSurfaceTintColor,
    required this.cardShadowColor,
    required this.textColor,
    required this.dialogBackgroundColor,
    required this.background,
    required this.foreground,
    required this.muted,
    required this.mutedForeground,
    required this.primaryColor,
    required this.primaryForeground,
    required this.iconActive,
    required this.iconInactive,
    required this.separator1,
    required this.separator2,
    required this.secondary,
    required this.secondaryForeground,
    required this.tab,
    required this.menuIconBg,
    required this.card,
    required this.cardForeground,
    required this.destructive,
  });

  factory AppColorScheme.light() => const AppColorScheme(
        primary: AppColor.primary,
        appBarBackground: AppColor.base10,
        scaffoldBackgroundColor: AppColor.base10,
        cardColor: AppColor.background,
        cardSurfaceTintColor: AppColor.background,
        cardShadowColor: AppColor.base20,
        dialogBackgroundColor: AppColor.base10,
        textBtnColor: AppColor.background,
        textColor: AppColor.foreground,
        background: AppColor.background,
        foreground: AppColor.foreground,
        muted: AppColor.muted,
        mutedForeground: AppColor.mutedForeground,
        primaryColor: AppColor.primaryColor,
        primaryForeground: AppColor.primaryForeground,
        iconActive: AppColor.iconActive,
        iconInactive: AppColor.iconInactive,
        separator1: AppColor.separator1,
        separator2: AppColor.separator2,
        secondary: AppColor.secondary,
        secondaryForeground: AppColor.secondaryForeground,
        tab: AppColor.tab,
        menuIconBg: AppColor.menuIconBg,
        card: AppColor.card,
        cardForeground: AppColor.cardForeground,
        destructive: AppColor.destructive,
      );

  factory AppColorScheme.dark() => const AppColorScheme(
        primary: AppColor.primary,
        appBarBackground: AppColor.backgroundDark,
        scaffoldBackgroundColor: AppColor.backgroundDark,
        cardColor: AppColor.cardDark,
        cardSurfaceTintColor: AppColor.cardDark,
        cardShadowColor: Colors.transparent,
        textBtnColor: AppColor.foregroundDark,
        dialogBackgroundColor: AppColor.base90,
        textColor: AppColor.foregroundDark,
        background: AppColor.backgroundDark,
        foreground: AppColor.foregroundDark,
        muted: AppColor.mutedDark,
        mutedForeground: AppColor.mutedForegroundDark,
        primaryColor: AppColor.primaryDark,
        primaryForeground: AppColor.primaryForegroundDark,
        iconActive: AppColor.iconActiveDark,
        iconInactive: AppColor.iconInactiveDark,
        separator1: AppColor.separator1Dark,
        separator2: AppColor.separator2Dark,
        secondary: AppColor.secondaryDark,
        secondaryForeground: AppColor.secondaryForegroundDark,
        tab: AppColor.tabDark,
        menuIconBg: AppColor.menuIconBgDark,
        card: AppColor.cardDark,
        cardForeground: AppColor.cardForegroundDark,
        destructive: AppColor.destructiveDark,
      );
}

class AppColor {
  static const primary = Color(0xFF417afe);
  static const primary10 = Color(0xFFDF7838);
  static const base10 = Color(0xFFFAF8F6);
  static const base20 = Color(0xFFDFD6D2);
  static const base30 = Color(0xFFDFD6D2);
  static const base40 = Color(0xFFCEC3BE);
  static const base60 = Color(0xFFBFB1A9);
  static const base70 = Color(0xFF877F7B);
  static const base80 = Color(0xFF524E4C);
  static const base100 = Color(0xFF0C0C0C);
  static const base90 = Color(0xFF3B3837);
  static const base50 = Color(0xFFB8AFAB);
  static const color996143 = Color(0xFF996143);
  static const colorB78267 = Color(0xFFB78267);
  static const color00EF2C = Color(0x00ffef2c);
  static const color00D7EF1A = Color(0xff00D7EF);
  static const colorA77053 = Color(0xFFA77053);
  static const colorDF7838 = Color(0xFFDF7838);
  static const color4C4C4C = Color(0xFF4C4C4C);
  static const colorFFCC00 = Color(0xFFFFCC00);
  static const color00A6FF = Color(0xFF00A6FF);

  static const Color scaffoldDark = Color(0xff222736);
  static const Color drawerBG = Color(0xFFE9F0F9);

  // VS Code Color Scheme
  static const background = Color(0xFFFFFFFF);
  static const foreground = Color(0xFF000000);
  static const muted = Color(0xFFEEEEEE);
  static const mutedForeground = Color(0xFF808080);
  static const primaryColor = Color(0xFF141414);
  static const primaryForeground = Color(0xFFFFFFFF);
  static const iconActive = Color(0xFF141414);
  static const iconInactive = Color(0xFFB8B8B8);
  static const separator1 = Color(0xFFD3D3D3);
  static const separator2 = Color(0xFF5E5E5E);
  static const secondary = Color(0xFFC5C5C5);
  static const secondaryForeground = Color(0xFF000000);
  static const tab = Color(0xFFFFFFFF);
  static const menuIconBg = Color(0x1A141414); // 10% opacity
  static const card = Color(0xFF141414);
  static const cardForeground = Color(0xFFFFFFFF);
  static const destructive = Color(0xFFFF7676);

  // Dark Mode
  static const backgroundDark = Color(0xFF353535);
  static const foregroundDark = Color(0xFFFFFFFF);
  static const mutedDark = Color(0xFF272727);
  static const mutedForegroundDark = Color(0xFFA7A7A7);
  static const primaryDark = Color(0xFFEFEFEF);
  static const primaryForegroundDark = Color(0xFF000000);
  static const iconActiveDark = Color(0xFFFFFFFF);
  static const iconInactiveDark = Color(0xFF727272);
  static const separator1Dark = Color(0xFF5E5E5E);
  static const separator2Dark = Color(0xFF5E5E5E);
  static const secondaryDark = Color(0xFF616161);
  static const secondaryForegroundDark = Color(0xFFFFFFFF);
  static const tabDark = Color(0xFF181818);
  static const menuIconBgDark = Color(0x1AFFFFFF); // 10% opacity
  static const cardDark = Color(0xFF141414);
  static const cardForegroundDark = Color(0xFFFFFFFF);
  static const destructiveDark = Color(0xFFFF6161);
}
