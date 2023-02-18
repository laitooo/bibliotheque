import 'package:bibliotheque/models/notifications_option.dart';
import 'package:bibliotheque/repos/notificatios_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum NotificationsOptionsStatus {
  loading,
  error,
  success,
}

class NotificationsOptionsState {
  final NotificationsOptionsStatus status;
  final NotificationsOptions? notificationsOptions;
  final NotificationsOptionError? error;

  NotificationsOptionsState(this.status,
      {this.notificationsOptions, this.error});
}

class LoadNotificationsOptions
    extends BlocEvent<NotificationsOptionsState, NotificationsOptionsBloc> {
  @override
  Stream<NotificationsOptionsState> toState(
      NotificationsOptionsState current, NotificationsOptionsBloc bloc) async* {
    yield NotificationsOptionsState(NotificationsOptionsStatus.loading);

    // TODO: add user id
    final res = await bloc._repo.getNotificationOptions('bloc._auth.user!.id');

    yield res.incase(
      value: (value) {
        return NotificationsOptionsState(
          NotificationsOptionsStatus.success,
          notificationsOptions: value,
        );
      },
      error: (error) {
        return NotificationsOptionsState(
          NotificationsOptionsStatus.error,
          error: error,
        );
      },
    );
  }
}

class UpdateNotificationsOptions
    extends BlocEvent<NotificationsOptionsState, NotificationsOptionsBloc> {
  final bool? newRecommendation;
  final bool? newBookSeries;
  final bool? newUpdateFromAuthors;
  final bool? newPriceDrop;
  final bool? newPurchase;
  final bool? newTipOrService;
  final bool? newSurvey;

  UpdateNotificationsOptions(
      {this.newRecommendation,
      this.newBookSeries,
      this.newUpdateFromAuthors,
      this.newPriceDrop,
      this.newPurchase,
      this.newTipOrService,
      this.newSurvey});
  @override
  Stream<NotificationsOptionsState> toState(
      NotificationsOptionsState current, NotificationsOptionsBloc bloc) async* {
    final old = current.notificationsOptions!;
    final newOptions = old.copyWith(
      newRecommendation: newRecommendation ?? old.newRecommendation,
      newBookSeries: newBookSeries ?? old.newBookSeries,
      newUpdateFromAuthors: newUpdateFromAuthors ?? old.newUpdateFromAuthors,
      newPriceDrop: newPriceDrop ?? old.newPriceDrop,
      newPurchase: newPurchase ?? old.newPurchase,
      newTipOrService: newTipOrService ?? old.newTipOrService,
      newSurvey: newSurvey ?? old.newSurvey,
    );

    final res = await bloc._repo.updateNotificationOptions(
      "userId",
      newOptions,
    );

    yield res.incase(
      value: (value) {
        return NotificationsOptionsState(
          NotificationsOptionsStatus.success,
          notificationsOptions: newOptions,
        );
      },
      error: (error) {
        return NotificationsOptionsState(
          NotificationsOptionsStatus.error,
          error: error,
        );
      },
    );
  }
}

class NotificationsOptionsBloc extends BaseBloc<NotificationsOptionsState> {
  final _repo = serviceLocator<NotificationsRepository>();
  NotificationsOptionsBloc()
      : super(NotificationsOptionsState(NotificationsOptionsStatus.loading));
}
