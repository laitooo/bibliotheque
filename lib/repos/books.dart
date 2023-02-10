import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class BooksRepository {
  Future<Result<List<Book>, PopularBooksError>> getPopularBooks();
  Future<Result<List<Book>, RecommendedBooksError>> searchBooks();
  Future<Result<List<Book>, RecommendedBooksError>> getCategoryBooks();
  Future<Result<List<Book>, RecommendedBooksError>> getRecommendedBooks();
}

class MockBooksRepository extends BooksRepository {
  @override
  Future<Result<List<Book>, PopularBooksError>> getPopularBooks() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return Result.value(
      List.generate(
        5,
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

    return Result.value(
      List.generate(
        5,
        (index) => generator.book(),
      ),
    );
  }

  @override
  Future<Result<List<Book>, RecommendedBooksError>> getCategoryBooks() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return Result.value(
      List.generate(
        5,
        (index) => generator.book(),
      ),
    );
  }

  @override
  Future<Result<List<Book>, RecommendedBooksError>> searchBooks() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return Result.value(
      List.generate(
        5,
        (index) => generator.book(),
      ),
    );
  }
}
