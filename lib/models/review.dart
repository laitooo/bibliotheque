import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.g.dart';
part 'review.freezed.dart';

enum StarsNumber {
  oneStar,
  twoStars,
  threeStars,
  fourStars,
  fiveStars,
}

@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    required String content,
    required String userId,
    required String userName,
    required String userCover,
    required bool hasLiked,
    required StarsNumber numStars,
    required int numLikes,
    required DateTime creationDate,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
