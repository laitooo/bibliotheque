import 'package:bibliotheque/repos/notificatios_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum UnreadNotificationsStatus {
  loading,
  error,
  success,
}

class UnreadNotificationsState {
  final UnreadNotificationsStatus status;
  final bool? hasNotification;
  final UnreadNotificationsError? error;

  UnreadNotificationsState(this.status, {this.hasNotification, this.error});
}

class LoadUnreadNotifications
    extends BlocEvent<UnreadNotificationsState, UnreadNotificationsBloc> {
  @override
  Stream<UnreadNotificationsState> toState(
      UnreadNotificationsState current, UnreadNotificationsBloc bloc) async* {
    final res = await bloc._repo.hasNotification("bloc._auth.user!.id");

    yield res.incase(
      value: (value) => UnreadNotificationsState(
        UnreadNotificationsStatus.success,
        hasNotification: value,
      ),
      error: (error) => UnreadNotificationsState(
        UnreadNotificationsStatus.error,
        error: error,
      ),
    );
  }
}

class UnreadNotificationsBloc extends BaseBloc<UnreadNotificationsState> {
  final _repo = serviceLocator<NotificationsRepository>();
  UnreadNotificationsBloc()
      : super(UnreadNotificationsState(UnreadNotificationsStatus.loading));
}
