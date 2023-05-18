import 'package:bibliotheque/entities/review_content.dart';
import 'package:bibliotheque/models/review.dart';
import 'package:bibliotheque/repos/auth_repo.dart';
import 'package:bibliotheque/repos/profile_repo.dart';
import 'package:bibliotheque/repos/reviews_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';

enum CreateReviewStatus {
  idle,
  sending,
  error,
  success,
}

class CreateReviewState {
  CreateReviewStatus status;
  final ReviewsError? error;

  CreateReviewState(this.status, {this.error});
}

class SubmitReview extends BlocEvent<CreateReviewState, CreateReviewBloc> {
  final ReviewContent reviewContent;

  SubmitReview(this.reviewContent);
  @override
  Stream<CreateReviewState> toState(
      CreateReviewState current, CreateReviewBloc bloc) async* {
    yield CreateReviewState(CreateReviewStatus.sending);

    if (reviewContent.rate < 1 || reviewContent.rate > 5) {
      yield CreateReviewState(
        CreateReviewStatus.error,
        error: ReviewsError.invalidRate,
      );
      return;
    }

    final profile = await bloc._profile.loadProfile(bloc._auth.user!.id);

    if (profile.isError) {
      yield CreateReviewState(
        CreateReviewStatus.error,
        error: ReviewsError.fetchingAvatar,
      );
      return;
    }

    final review = Review(
      id: generator.id(),
      content: reviewContent.content,
      userId: bloc._auth.user!.id,
      userName: bloc._auth.user!.username,
      hasLiked: false,
      numStars: rateToNumStars(reviewContent.rate),
      numLikes: 0,
      creationDate: DateTime.now(),
      userCover: profile.asValue.avatarUrl,
    );

    final res = await bloc._repo.createReview(review);

    yield res.incase(
      value: (value) {
        return CreateReviewState(
          CreateReviewStatus.success,
        );
      },
      error: (error) {
        return CreateReviewState(
          CreateReviewStatus.error,
          error: error,
        );
      },
    );
  }

  StarsNumber rateToNumStars(double rate) {
    if (rate == 5) {
      return StarsNumber.fiveStars;
    } else if (rate == 4) {
      return StarsNumber.fourStars;
    } else if (rate == 3) {
      return StarsNumber.threeStars;
    } else if (rate == 2) {
      return StarsNumber.twoStars;
    } else {
      return StarsNumber.oneStar;
    }
  }
}

class CreateReviewBloc extends BaseBloc<CreateReviewState> {
  final _repo = serviceLocator<ReviewsRepository>();
  final _auth = serviceLocator<AuthRepository>();
  final _profile = serviceLocator<ProfileRepository>();

  CreateReviewBloc() : super(CreateReviewState(CreateReviewStatus.idle));
}
