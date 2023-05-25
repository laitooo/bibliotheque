import 'package:bibliotheque/entities/filter_options.dart';
import 'package:bibliotheque/features.dart';
import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

enum SortingMethod {
  trending,
  newReleases,
  highestRating,
  lowestRating,
  highestPrice,
  lowestPrice,
}

enum RatingRange {
  all,
  fourHalfPlus,
  fourPlus,
}

abstract class SearchRepository {
  Future<Result<List<Book>, SearchError>> search(
      String query, FilterOptions filterOptions);
  Future<Result<List<String>, SearchHistoryError>> getSearchHistory();
  Future<Result<void, SearchHistoryError>> clearSearchHistory();
  Future<Result<void, SearchHistoryError>> addPreviousSearchQuery(String query);
  Future<Result<void, SearchHistoryError>> removePreviousSearchQuery(
      String query);
}

class MockSearchRepository extends SearchRepository {
  @override
  Future<Result<List<Book>, SearchError>> search(
      String query, FilterOptions filterOptions) async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(SearchError.networkError);
    }

    return Result.value(
      List.generate(
        Features.isEmptyLists ? 0 : 10,
        (index) => generator.book(),
      ),
    );
  }

  @override
  Future<Result<List<String>, SearchHistoryError>> getSearchHistory() async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(SearchHistoryError.loadingError);
    }

    return Result.value(
      List.generate(
        Features.isEmptyLists ? 0 : 10,
        (index) => generator.searchHistory(),
      ),
    );
  }

  @override
  Future<Result<void, SearchHistoryError>> clearSearchHistory() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(SearchHistoryError.clearingError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<void, SearchHistoryError>> addPreviousSearchQuery(
      String query) async {
    // Make sure there's no duplicate
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(SearchHistoryError.addingError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<void, SearchHistoryError>> removePreviousSearchQuery(
      String query) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(SearchHistoryError.removingError);
    }

    return Result.value(null);
  }
}
