import 'package:bibliotheque/features.dart';
import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class BooksRepository {
  Future<Result<List<Book>, PopularBooksError>> getPopularBooks();
  Future<Result<List<Book>, SearchError>> searchBooks();
  Future<Result<List<Book>, CategoriesError>> getCategoryBooks();
  Future<Result<List<Book>, RecommendedBooksError>> getRecommendedBooks();
}

class MockBooksRepository extends BooksRepository {
  @override
  Future<Result<List<Book>, PopularBooksError>> getPopularBooks() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(PopularBooksError.networkError);
    }

    return Result.value(
      List.generate(
        Features.isEmptyLists ? 0 : 5,
        (index) => generator.book(),
      ),
    );
  }

  @override
  Future<Result<List<Book>, RecommendedBooksError>>
      getRecommendedBooks() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(RecommendedBooksError.networkError);
    }

    return Result.value(
      List.generate(
        Features.isEmptyLists ? 0 : 5,
        (index) => generator.book(),
      ),
    );
  }

  @override
  Future<Result<List<Book>, CategoriesError>> getCategoryBooks() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(CategoriesError.networkError);
    }

    return Result.value(
      List.generate(
        Features.isEmptyLists ? 0 : 5,
        (index) => generator.book(),
      ),
    );
  }

  @override
  Future<Result<List<Book>, SearchError>> searchBooks() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(SearchError.networkError);
    }

    return Result.value(
      List.generate(
        Features.isEmptyLists ? 0 : 5,
        (index) => generator.book(),
      ),
    );
  }
}
