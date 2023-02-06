import 'package:flutter/material.dart';

// ignore_for_file: annotate_overrides

const String arabicFontFamily = "Baloo";
const String englishFontFamily = "Ubuntu";

class _ChildThemeData {
  final AppThemeData root;
  _ChildThemeData(this.root);
}

abstract class AppThemeData {
  ThemeData material(BuildContext context) => ThemeData(
        primaryColor: primaryColor,
        unselectedWidgetColor: mainButtonTextColor,
        radioTheme: RadioThemeData(
          overlayColor:
              MaterialStateProperty.all(primaryColor.withOpacity(0.3)),
          fillColor: MaterialStateProperty.all(primaryColor),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: snackBarBackgroundColor,
          contentTextStyle: TextStyle(
            color: snackBarTextColor,
          ),
        ),
      );

  Color get backgroundColor;
  Color get primaryColor;
  Color get secondaryColor;
  Color get hintColor;
  Color get cardColor;
  Color get borderColor;
  Color get titleColor;
  Color get bottomSheetHolderColor;
  Color get dropDownTextColor;
  Color get dropDownIconColor;
  Color get dropDownBackgroundColor;
  Color get primaryTextColor;
  Color get secondaryTextColor;
  Color get priceColor;
  Color get labelColor;
  Color get nameColor;
  Color get selectedIconColor;
  Color get selectedIconColor2;
  Color get unselectedIconColor;
  Color get iconColor;
  Color get iconBackgroundColor;
  Color get searchColor;
  Color get searchColor2;
  Color get searchBackgroundColor;
  Color get activeChipTextColor;
  Color get inactiveChipTextColor;
  Color get activeChipBackgroundColor;
  Color get inactiveChipBackgroundColor;
  Color get inactiveChipBorderColor;
  Color get mainButtonTextColor;
  Color get mainButtonShadowColor;
  Color get appInfoText;
  Color get paymentIconColor;
  Color get snackBarTextColor;
  Color get snackBarBackgroundColor;
  Color get cancelButtonTextColor;
  Color get calendarActiveBackgroundColor;
  Color get calendarActiveTextColor;
  Color get calendarInactiveTextColor;
  Color get removeIconBackgroundColor;
  _InputThemeData get input;
  _AppBarThemeData get appBar;
  _SelectorThemeData get selector;
}

class _InputThemeData extends _ChildThemeData {
  _InputThemeData(AppThemeData root) : super(root);

  Color get borderColor => const Color(0xFFE9E7E2);
  Color get hintColor => const Color(0xFF767676);
  Color get errorColor => const Color(0xFFDC4C44);
  Color get backgroundColor => Colors.white;
}

class _AppBarThemeData extends _ChildThemeData {
  _AppBarThemeData(AppThemeData root) : super(root);

  Color get actionButtonBorderColor => const Color(0xFFE9E7E2);
}

class _SelectorThemeData extends _ChildThemeData {
  _SelectorThemeData(AppThemeData root) : super(root);

  Color get quantityIconColor => const Color(0x80767676);
  Color get quantityIconBorderColor => const Color(0xFFE9E7E2);
  Color get quantityIconBackgroundColor => const Color(0xFFF9F6F4);
}

class LightThemeData extends AppThemeData {
  material(context) => super.material(context).copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          color: backgroundColor,
          foregroundColor: const Color(0xFF242424),
          elevation: 0,
          centerTitle: true,
        ),
      );

  get backgroundColor => Colors.white;
  get primaryColor => const Color(0xFF01A0C6);
  get secondaryColor => Colors.orange;
  get hintColor => const Color(0xFF767676);
  get cardColor => Colors.white;
  get borderColor => const Color(0xFFE9E7E2);
  get titleColor => Colors.black;
  get bottomSheetHolderColor => Colors.black.withOpacity(0.3);
  get dropDownTextColor => const Color(0xFF5D5D5D);
  get dropDownIconColor => const Color(0xFF767676);
  get dropDownBackgroundColor => Colors.white;
  get primaryTextColor => const Color(0xFF242424);
  get secondaryTextColor => const Color(0xFF767676);
  get priceColor => const Color(0xFFFFA441);
  get labelColor => const Color(0xFF230316);
  get nameColor => const Color(0xFF5D5D5D);
  get selectedIconColor => const Color(0xFFE1747A);
  get selectedIconColor2 => const Color(0xFF32B6A4);
  get unselectedIconColor => const Color(0xFFEBEAE9);
  get iconColor => const Color(0xFF767676);
  get iconBackgroundColor => Colors.white;
  get searchColor => const Color(0xFF767676);
  get searchColor2 => const Color(0xFF5D5D5D);
  get searchBackgroundColor => const Color(0xFFFFFFFF);
  get activeChipTextColor => const Color(0xFF01A0C6);
  get inactiveChipTextColor => const Color(0xFF5D5D5D);
  get activeChipBackgroundColor => const Color(0x3858A7F8);
  get inactiveChipBackgroundColor => Colors.transparent;
  get inactiveChipBorderColor => const Color(0xFFE9E7E2);
  get mainButtonTextColor => Colors.white;
  get appInfoText => const Color(0xFF767676);
  get mainButtonShadowColor => const Color(0xFF01A0C6);
  get paymentIconColor => const Color(0x425D647F);
  get snackBarTextColor => const Color(0xFFFFFFFF);
  get snackBarBackgroundColor => const Color(0xFF303030);
  get cancelButtonTextColor => const Color(0xFF35383F);
  get calendarActiveBackgroundColor => const Color(0xFF6A003E);
  get calendarActiveTextColor => const Color(0xFFFFFFFF);
  get calendarInactiveTextColor => const Color(0xFF444444);
  get removeIconBackgroundColor => const Color(0xFFF1F0EE);
  late final input = _InputThemeData(this);
  late final appBar = _AppBarThemeData(this);
  late final selector = _SelectorThemeData(this);
}

class DarkThemeData extends AppThemeData {
  material(context) => super.material(context).copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          color: backgroundColor,
          foregroundColor: const Color(0xFF242424),
          elevation: 0,
          centerTitle: true,
        ),
      );

  get backgroundColor => const Color(0xFF00151A);
  get primaryColor => const Color(0xFF01A0C6);
  get secondaryColor => Colors.orange;
  get hintColor => const Color(0xFFA8A8A8);
  get cardColor => const Color(0xFF00151A);
  get borderColor => const Color(0XFF0F323B);
  get titleColor => const Color(0xFFA8A8A8);
  get bottomSheetHolderColor => const Color(0xFF0F323B);
  get dropDownTextColor => const Color(0xFFA8A8A8);
  get dropDownIconColor => const Color(0xFFA8A8A8);
  get dropDownBackgroundColor => const Color(0xFF012934);
  get primaryTextColor => const Color(0xFFFDFDFD);
  get secondaryTextColor => const Color(0xFFA8A8A8);
  get priceColor => const Color(0xFFFFA441);
  get labelColor => const Color(0xFFFDFDFD);
  get nameColor => const Color(0xFFA8A8A8);
  get selectedIconColor => const Color(0xFFE1747A);
  get selectedIconColor2 => const Color(0xFF32B6A4);
  get unselectedIconColor => const Color(0xFF15262A);
  get iconColor => const Color(0xFFA8A8A8);
  get iconBackgroundColor => const Color(0xFF00151A);
  get searchColor => const Color(0xFFA8A8A8);
  get searchColor2 => const Color(0xFF767676);
  get searchBackgroundColor => const Color(0xFF00151A);
  get activeChipTextColor => const Color(0xFFFDFDFD);
  get inactiveChipTextColor => const Color(0xFFA8A8A8);
  get activeChipBackgroundColor => const Color(0xFF01A0C6);
  get inactiveChipBackgroundColor => const Color(0xFF012934);
  get inactiveChipBorderColor => const Color(0xFF012934);
  get mainButtonTextColor => Colors.white;
  get appInfoText => const Color(0xFFA8A8A8);
  get mainButtonShadowColor => const Color(0xFF00151A);
  get paymentIconColor => const Color(0x425D647F);
  get snackBarTextColor => const Color(0xFFFDFDFD);
  get snackBarBackgroundColor => const Color(0xFF012934);
  get cancelButtonTextColor => const Color(0xFFFDFDFD);
  get calendarActiveBackgroundColor => const Color(0xFF6A003E);
  get calendarActiveTextColor => const Color(0xFFFDFDFD);
  get calendarInactiveTextColor => const Color(0xFFA8A8A8);
  get removeIconBackgroundColor => const Color(0xFF012934);
  late final input = _InputThemeData(this);
  late final appBar = _AppBarThemeData(this);
  late final selector = _SelectorThemeData(this);
}
