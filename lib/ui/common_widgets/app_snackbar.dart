import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';

extension AppSnackBar on BuildContext {
  showSnackBar({required String text}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: theme.primaryColor,
        content: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: theme.textColor2,
          ),
        ),
      ),
    );
  }
}
