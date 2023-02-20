import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_option.g.dart';
part 'notifications_option.freezed.dart';

@freezed
class NotificationsOptions with _$NotificationsOptions {
  const factory NotificationsOptions({
    required String userId,
    required bool newRecommendation,
    required bool newBookSeries,
    required bool newUpdateFromAuthors,
    required bool newPriceDrop,
    required bool newPurchase,
    required bool newTipOrService,
    required bool newSurvey,
  }) = _NotificationsOptions;

  factory NotificationsOptions.fromJson(Map<String, dynamic> json) =>
      _$NotificationsOptionsFromJson(json);
}
