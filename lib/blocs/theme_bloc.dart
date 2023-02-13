import 'package:bibliotheque/ui/theme/data.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeState {
  final AppThemeData theme;

  ThemeState(this.theme);
}

final _light = LightThemeData();
final _dark = DarkThemeData();

class LoadTheme extends BlocEvent<ThemeState, ThemeBloc> {
  final bool isChanging;

  LoadTheme(this.isChanging);

  @override
  Stream<ThemeState> toState(ThemeState current, ThemeBloc bloc) async* {
    final isNightMode = prefs.isNightMode() ?? false;
    if (isChanging) {
      await prefs.setIsNightMode(!isNightMode);
      yield ThemeState(isNightMode ? _light : _dark);
    } else {
      yield ThemeState(isNightMode ? _dark : _light);
    }
  }
}

class ThemeBloc extends BaseBloc<ThemeState> {
  ThemeBloc()
      : super(ThemeState(prefs.isNightMode() ?? false ? _dark : _light));
}

extension ThemeContext on BuildContext {
  AppThemeData get theme => BlocProvider.of<ThemeBloc>(this).state.theme;
}
