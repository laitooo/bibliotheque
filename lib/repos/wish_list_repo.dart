import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class WishListRepository {
  Future<Result<List<Book>, WishListError>> getWishList();
}

class MockWishListRepository extends WishListRepository {
  @override
  Future<Result<List<Book>, WishListError>> getWishList() async {
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
