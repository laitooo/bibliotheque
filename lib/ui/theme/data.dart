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
  Color get iconColor1;
  Color get activeColor;
  Color get inActiveColor;
  Color get tagBackgroundColor;
  Color get dividerColor;
  Color get iconBackgroundColor;
  Color get filterItemColor1;
  Color get filterItemColor2;
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

  late final input = _InputThemeData(this);
  late final appBar = _AppBarThemeData(this);
  late final selector = _SelectorThemeData(this);

  Color get primaryColor => Colors.orange;
  Color get secondaryColor => Colors.orangeAccent.shade100;
  Color get backgroundColor => Colors.white;
  Color get textColor1 => Colors.black;
  Color get textColor2 => Colors.white;
  Color get textColor3 => primaryColor;
  Color get textColor4 => Colors.grey;
  Color get textColor5 => const Color(0xFF424242);
  Color get iconColor1 => Colors.black;
  Color get activeColor => primaryColor;
  Color get inActiveColor => Colors.grey;
  Color get tagBackgroundColor => const Color(0xFFE4E5EF);
  Color get dividerColor => Colors.grey.shade400;
  Color get iconBackgroundColor => const Color(0x221144bb);
  Color get filterItemColor1 => primaryColor;
  Color get filterItemColor2 => backgroundColor;
}

class DarkThemeData extends LightThemeData {}
