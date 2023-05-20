import 'package:bibliotheque/features.dart';
import 'package:bibliotheque/models/notification.dart';
import 'package:bibliotheque/models/notifications_option.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class NotificationsRepository {
  Future<Result<List<Notification>, NotificationsError>> listNotifications(
      String userId);
  Future<Result<bool, UnreadNotificationsError>> hasNotification(String userId);
  Future<Result<NotificationsOptions, NotificationsOptionError>>
      getNotificationOptions(String userId);
  Future<Result<void, NotificationsOptionError>> updateNotificationOptions(
    String userId,
    NotificationsOptions options,
  );
}

class MockNotificationsRepository extends NotificationsRepository {
  @override
  Future<Result<List<Notification>, NotificationsError>> listNotifications(
      String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    var list = List.generate(
      10,
      (index) => generator.notification(),
    );

    if (Features.isMockErrors) {
      return Result.error(NotificationsError.networkError);
    }

    return Result.value(list);
  }

  @override
  Future<Result<bool, UnreadNotificationsError>> hasNotification(
      String userId) async {
    if (Features.isMockErrors) {
      return Result.error(UnreadNotificationsError.networkError);
    }

    return Result.value(Generator().boolean());
  }

  @override
  Future<Result<NotificationsOptions, NotificationsOptionError>>
      getNotificationOptions(String userId) async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(NotificationsOptionError.loadingError);
    }

    return Result.value(Generator().notificationsOption());
  }

  @override
  Future<Result<void, NotificationsOptionError>> updateNotificationOptions(
      String userId, NotificationsOptions options) async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(NotificationsOptionError.updatingError);
    }

    return Result.value(null);
  }
}
