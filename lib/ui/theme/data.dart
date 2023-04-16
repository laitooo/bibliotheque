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
        unselectedWidgetColor: inActiveColor,
        radioTheme: RadioThemeData(
          overlayColor:
              MaterialStateProperty.all(primaryColor.withOpacity(0.3)),
          fillColor: MaterialStateProperty.all(primaryColor),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: backgroundColor,
          contentTextStyle: TextStyle(
            color: textColor1,
          ),
        ),
      );

  _InputThemeData get input;
  _AppBarThemeData get appBar;
  _SelectorThemeData get selector;

  Color get primaryColor;
  Color get secondaryColor;
  Color get backgroundColor;
  Color get textColor1;
  Color get textColor2;
  Color get textColor3;
  Color get textColor4;
  Color get textColor5;
  Color get textColor6;
  Color get buttonColor1;
  Color get buttonColor2;
  Color get buttonColor3;
  Color get iconColor1;
  Color get iconColor2;
  Color get iconColor3;
  Color get iconColor4;
  Color get activeColor;
  Color get inActiveColor;
  Color get tagBackgroundColor;
  Color get dividerColor;
  Color get iconBackgroundColor;
  Color get filterItemColor1;
  Color get filterItemColor2;
  Color get filterItemColor3;
  Color get filterCardBackground;
  Color get textFieldActiveColor;
  Color get textFieldInactiveColor;
  Color get fullStarColor;
  Color get emptyStarColor;
  Color get progressBarBackgroundColor;
  Color get googleButtonBackgroundColor;
  Color get flatButtonTextColor;
  Color get flatButtonBackgroundColor;
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
  Color get progressBarBackgroundColor => Colors.grey.shade300;
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

  late final input = _InputThemeData(this);
  late final appBar = _AppBarThemeData(this);
  late final selector = _SelectorThemeData(this);

  Color get primaryColor => const Color(0xFFF89300);
  Color get secondaryColor => Colors.orangeAccent.shade100;
  Color get backgroundColor => Colors.white;
  Color get textColor1 => Colors.black;
  Color get textColor2 => Colors.white;
  Color get textColor3 => primaryColor;
  Color get textColor4 => Colors.grey;
  Color get textColor5 => const Color(0xFF424242);
  Color get textColor6 => Colors.red;
  Color get buttonColor1 => primaryColor;
  Color get buttonColor2 => const Color(0x11FF9800);
  Color get buttonColor3 => const Color(0x11FF9800);
  Color get iconColor1 => Colors.black;
  Color get iconColor2 => primaryColor;
  Color get iconColor3 => Colors.white;
  Color get iconColor4 => Colors.grey;
  Color get activeColor => primaryColor;
  Color get inActiveColor => Colors.grey;
  Color get tagBackgroundColor => const Color(0xFFE4E5EF);
  Color get dividerColor => Colors.grey.shade400;
  Color get iconBackgroundColor => const Color(0x221144bb);
  Color get filterItemColor1 => primaryColor;
  Color get filterItemColor2 => backgroundColor;
  Color get filterItemColor3 => backgroundColor;
  Color get filterCardBackground => Colors.grey;
  Color get textFieldActiveColor => primaryColor;
  Color get textFieldInactiveColor => const Color(0xFF666666);
  Color get fullStarColor => primaryColor;
  Color get emptyStarColor => primaryColor.withOpacity(0.3);
  Color get progressBarBackgroundColor => Colors.grey.shade300;
  Color get googleButtonBackgroundColor => Colors.white;
  Color get flatButtonTextColor => primaryColor;
  Color get flatButtonBackgroundColor => const Color(0x33FF9800);
}

class DarkThemeData extends AppThemeData {
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

  late final input = _InputThemeData(this);
  late final appBar = _AppBarThemeData(this);
  late final selector = _SelectorThemeData(this);

  Color get primaryColor => const Color(0xFFF89300);
  Color get secondaryColor => Colors.orangeAccent.shade100;
  Color get backgroundColor => const Color(0xFF181A20);
  Color get textColor1 => Colors.white;
  Color get textColor2 => Colors.white;
  Color get textColor3 => primaryColor;
  Color get textColor4 => const Color(0xFFE0E0E2);
  Color get textColor5 => const Color(0xFF424242);
  Color get textColor6 => Colors.red;
  Color get buttonColor1 => primaryColor;
  Color get buttonColor2 => const Color(0x11FF9800);
  Color get buttonColor3 => const Color(0xFF35383F);
  Color get iconColor1 => Colors.white;
  Color get iconColor2 => primaryColor;
  Color get iconColor3 => Colors.white;
  Color get iconColor4 => const Color(0xFFE0E0E2);
  Color get activeColor => primaryColor;
  Color get inActiveColor => const Color(0xFF626160);
  Color get tagBackgroundColor => const Color(0xFF35383F);
  Color get dividerColor => Colors.grey.shade700;
  Color get iconBackgroundColor => const Color(0x221144bb);
  Color get filterItemColor1 => primaryColor;
  Color get filterItemColor2 => backgroundColor;
  Color get filterItemColor3 => Colors.white;
  Color get filterCardBackground => Colors.grey;
  Color get textFieldActiveColor => primaryColor;
  Color get textFieldInactiveColor => Colors.white;
  Color get fullStarColor => primaryColor;
  Color get emptyStarColor => primaryColor.withOpacity(0.3);
  Color get progressBarBackgroundColor => const Color(0xFF35383F);
  Color get googleButtonBackgroundColor => const Color(0xFF1F222A);
  Color get flatButtonTextColor => Colors.white;
  Color get flatButtonBackgroundColor => Colors.grey.withOpacity(0.7);
}
