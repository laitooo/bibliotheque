import 'package:bibliotheque/models/review.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class ReviewsRepository {
  Future<Result<List<Review>, ReviewsError>> getReviews(
      {StarsNumber? starsNumber});
}

class MockReviewsRepository extends ReviewsRepository {
  @override
  Future<Result<List<Review>, ReviewsError>> getReviews(
      {StarsNumber? starsNumber}) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return Result.value(
      List.generate(
        5,
        (index) => generator.review(starsNumber: starsNumber),
      ),
    );
  }
}
