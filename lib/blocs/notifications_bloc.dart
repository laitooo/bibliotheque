import 'package:bibliotheque/models/notification.dart';
import 'package:bibliotheque/repos/notificatios_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum NotificationsListStatus {
  loading,
  error,
  success,
}

class NotificationsListState {
  final NotificationsListStatus status;
  final List<Notification>? notifications;
  final NotificationsError? error;

  NotificationsListState(this.status, {this.notifications, this.error});
}

class LoadNotificationsList
    extends BlocEvent<NotificationsListState, NotificationsListBloc> {
  @override
  Stream<NotificationsListState> toState(
      NotificationsListState current, NotificationsListBloc bloc) async* {
    yield NotificationsListState(NotificationsListStatus.loading);

    // TODO: add user id
    final res = await bloc._repo.listNotifications('bloc._auth.user!.id');

    yield res.incase(
      value: (value) {
        return NotificationsListState(
          NotificationsListStatus.success,
          notifications: value,
        );
      },
      error: (error) {
        return NotificationsListState(
          NotificationsListStatus.error,
          error: error,
        );
      },
    );
  }
}

class NotificationsListBloc extends BaseBloc<NotificationsListState> {
  final _repo = serviceLocator<NotificationsRepository>();
  NotificationsListBloc()
      : super(NotificationsListState(NotificationsListStatus.loading));
}
