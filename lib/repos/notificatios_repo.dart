import 'package:bibliotheque/models/notification.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class NotificationsRepository {
  Future<Result<List<Notification>, NotificationsError>> listNotifications(
      String userId);
  Future<Result<bool, UnreadNotificationsError>> hasNotification(String userId);
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

    return Result.value(list);
  }

  @override
  Future<Result<bool, UnreadNotificationsError>> hasNotification(
      String userId) async {
    return Result.value(Generator().boolean());
  }
}
