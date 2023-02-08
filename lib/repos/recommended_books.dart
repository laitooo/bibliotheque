import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class RecommendedBooksRepository {
  Future<Result<List<Book>, RecommendedBooksError>> getRecommendedBooks();
}

class MockRecommendedBooksRepository extends RecommendedBooksRepository {
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
}
