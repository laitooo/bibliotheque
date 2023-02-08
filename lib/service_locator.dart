import 'package:bibliotheque/i18n/translations.g.dart';
import 'package:bibliotheque/repos/categories.dart';
import 'package:bibliotheque/repos/popular_books.dart';
import 'package:bibliotheque/repos/recommended_books.dart';
import 'package:bibliotheque/repos/wish_list.dart';
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = Preferences();
  await prefs.init();

  String storedLocale = prefs.getPreferredLanguage() ?? 'en';
  LocaleSettings.setLocaleRaw(storedLocale);

  serviceLocator.registerSingleton<PopularBooksRepository>(
    MockPopularBooksRepository(),
  );
  serviceLocator.registerSingleton<CategoriesRepositories>(
    MockCategoriesRepositories(),
  );
  serviceLocator.registerSingleton<RecommendedBooksRepository>(
    MockRecommendedBooksRepository(),
  );
  serviceLocator.registerSingleton<WishListRepository>(
    MockWishListRepository(),
  );
}
