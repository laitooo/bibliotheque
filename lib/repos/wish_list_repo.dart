import 'package:bibliotheque/features.dart';
import 'package:bibliotheque/models/book.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class WishListRepository {
  Future<Result<List<Book>, WishListError>> getWishList(bool loadAll);
  Future<Result<bool, WishListError>> isInWishList(String bookId);
  Future<Result<void, WishListError>> removeFromWishList(String bookId);
  Future<Result<void, WishListError>> addToWishList(Book book);
}

class MockWishListRepository extends WishListRepository {
  @override
  Future<Result<List<Book>, WishListError>> getWishList(bool loadAll) async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(WishListError.loadingListError);
    }

    return Result.value(
      List.generate(
        Features.isEmptyLists
            ? 0
            : loadAll
                ? 12
                : 5,
        (index) => generator.book(),
      ),
    );
  }

  @override
  Future<Result<void, WishListError>> removeFromWishList(String bookId) async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(WishListError.removingError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<void, WishListError>> addToWishList(Book book) async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(WishListError.addingError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<bool, WishListError>> isInWishList(String bookId) async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(WishListError.loadingStatusError);
    }

    return Result.value(generator.boolean());
  }
}
