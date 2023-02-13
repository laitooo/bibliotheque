import 'package:bibliotheque/models/book_details.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class BookDetailsRepository {
  Future<Result<BookDetails, BookDetailsError>> getBookDetails(String bookId);
}

class MockBookDetailsRepository extends BookDetailsRepository {
  @override
  Future<Result<BookDetails, BookDetailsError>> getBookDetails(
      String bookId) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return Result.value(
      generator.bookDetails(),
    );
  }
}
