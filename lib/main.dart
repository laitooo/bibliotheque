import 'package:bibliotheque/blocs/popular_books.dart';
import 'package:bibliotheque/blocs/theme.dart';
import 'package:bibliotheque/i18n/translations.g.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await initServices();

  runApp(
    TranslationProvider(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.fromWindow(
      child: BlocProvider(
        create: (_) => ThemeBloc()..add(LoadTheme(false)),
        child: Builder(builder: (context) {
          return BlocConsumer<ThemeBloc, ThemeState>(
            listener: (context, state) {
              rebuildAllChildren(context);
            },
            builder: (context, state) {
              return MaterialApp(
                title: 'Soqia Donor',
                locale: TranslationProvider.of(context).flutterLocale,
                supportedLocales: LocaleSettings.supportedLocales,
                localizationsDelegates: GlobalMaterialLocalizations.delegates,
                theme: state.theme.material(context),
                home: BlocProvider(
                  create: (_) => PopularBooksBloc()..add(LoadPopularBooks()),
                  child: HomeScreen(),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
