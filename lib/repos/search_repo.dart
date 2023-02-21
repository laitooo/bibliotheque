import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class SearchRepository {
  Future<Result<List<Book>, SearchError>> search(String query);
}

class MockSearchRepository extends SearchRepository {
  @override
  Future<Result<List<Book>, SearchError>> search(String query) async {
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
