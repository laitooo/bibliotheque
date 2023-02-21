import 'package:bibliotheque/models/review.dart';
import 'package:bibliotheque/repos/reviews_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum ReviewsStatus {
  loading,
  error,
  success,
}

class ReviewsState {
  final ReviewsStatus status;
  final List<Review>? reviews;
  final ReviewsError? error;

  ReviewsState(this.status, {this.reviews, this.error});
}

class LoadReviews extends BlocEvent<ReviewsState, ReviewsBloc> {
  final StarsNumber? starsNumber;

  LoadReviews({this.starsNumber});
  @override
  Stream<ReviewsState> toState(ReviewsState current, ReviewsBloc bloc) async* {
    yield ReviewsState(ReviewsStatus.loading, reviews: current.reviews);

    final res = await bloc._repo.getReviews(starsNumber: starsNumber);

    yield res.incase(
      value: (value) {
        return ReviewsState(
          ReviewsStatus.success,
          reviews: value,
        );
      },
      error: (error) {
        return ReviewsState(
          ReviewsStatus.error,
          error: error,
        );
      },
    );
  }
}

class ReviewsBloc extends BaseBloc<ReviewsState> {
  final _repo = serviceLocator.get<ReviewsRepository>();

  ReviewsBloc() : super(ReviewsState(ReviewsStatus.loading));
}
