import 'package:bibliotheque/entities/filter_options.dart';
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
}

class MockSearchRepository extends SearchRepository {
  @override
  Future<Result<List<Book>, SearchError>> search(
      String query, FilterOptions filterOptions) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return Result.value(
      List.generate(
        10,
        (index) => generator.book(),
      ),
    );
  }
}
