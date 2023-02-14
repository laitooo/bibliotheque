import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.g.dart';
part 'notification.freezed.dart';

enum NotificationType {
  creditCardConnected,
  newUpdateAvailable,
  multipleCardFeatures,
  securityUpdates,
  others,
}

enum UserRole {
  donor,
  driver,
}

enum NotificationTarget {
  user,
  donor,
  driver,
}

@freezed
class Notification with _$Notification {
  const factory Notification({
    required String id,
    required String user,
    required NotificationEvent event,
    required NotificationTarget target,
    required UserRole role,
    required String title,
    required String body,
    required String titleAr,
    required String bodyAr,
    required DateTime date,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent({
    required NotificationType type,
    required Map<String, dynamic> context,
  }) = _NotificationEvent;

  factory NotificationEvent.fromJson(Map<String, dynamic> json) =>
      _$NotificationEventFromJson(json);
}
