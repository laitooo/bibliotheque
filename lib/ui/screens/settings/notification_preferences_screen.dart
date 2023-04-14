import 'package:bibliotheque/blocs/notifications_options_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../i18n/translations.dart';
import '../../common_widgets/progress_indicator.dart';
import '../../common_widgets/svg.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({Key? key}) : super(key: key);

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.account.notifications.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: context.theme.textColor1,
          ),
        ),
        leading: IconButton(
          icon: const Svg('back.svg'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<NotificationsOptionsBloc, NotificationsOptionsState>(
        builder: (context, state) {
          if (state.status == NotificationsOptionsStatus.loading) {
            return const Center(
              child: AppProgressIndicator(),
            );
          }

          if (state.status == NotificationsOptionsStatus.error) {
            return TryAgainWidget(
              onPressed: () {
                BlocProvider.of<NotificationsOptionsBloc>(context)
                    .add(LoadNotificationsOptions());
              },
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              const SizedBox(height: 10),
              Text(
                t.account.notifications.notifyMeWhen,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: context.theme.textColor1,
                ),
              ),
              const SizedBox(height: 20),
              _item(
                context,
                t.account.notifications.newRecommendation,
                state.notificationsOptions!.newRecommendation,
                (newVal) {
                  BlocProvider.of<NotificationsOptionsBloc>(context).add(
                    UpdateNotificationsOptions(
                      newRecommendation: newVal,
                    ),
                  );
                },
              ),
              _item(
                context,
                t.account.notifications.newBookSeries,
                state.notificationsOptions!.newBookSeries,
                (newVal) {
                  BlocProvider.of<NotificationsOptionsBloc>(context).add(
                    UpdateNotificationsOptions(
                      newBookSeries: newVal,
                    ),
                  );
                },
              ),
              _item(
                context,
                t.account.notifications.authorsUpdate,
                state.notificationsOptions!.newUpdateFromAuthors,
                (newVal) {
                  BlocProvider.of<NotificationsOptionsBloc>(context).add(
                    UpdateNotificationsOptions(
                      newUpdateFromAuthors: newVal,
                    ),
                  );
                },
              ),
              _item(
                context,
                t.account.notifications.priceDrop,
                state.notificationsOptions!.newPriceDrop,
                (newVal) {
                  BlocProvider.of<NotificationsOptionsBloc>(context).add(
                    UpdateNotificationsOptions(
                      newPriceDrop: newVal,
                    ),
                  );
                },
              ),
              _item(
                context,
                t.account.notifications.whenPurchase,
                state.notificationsOptions!.newPurchase,
                (newVal) {
                  BlocProvider.of<NotificationsOptionsBloc>(context).add(
                    UpdateNotificationsOptions(
                      newPurchase: newVal,
                    ),
                  );
                },
              ),
              _item(
                context,
                t.account.notifications.newTips,
                state.notificationsOptions!.newTipOrService,
                (newVal) {
                  BlocProvider.of<NotificationsOptionsBloc>(context).add(
                    UpdateNotificationsOptions(
                      newTipOrService: newVal,
                    ),
                  );
                },
              ),
              _item(
                context,
                t.account.notifications.participateInSurvey,
                state.notificationsOptions!.newSurvey,
                (newVal) {
                  BlocProvider.of<NotificationsOptionsBloc>(context).add(
                    UpdateNotificationsOptions(
                      newSurvey: newVal,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  _item(BuildContext context, String title, bool value,
      void Function(bool newVal) onChanged) {
    return Row(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: context.theme.textColor1,
            ),
          ),
        ),
        const Spacer(),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: context.theme.primaryColor,
        ),
      ],
    );
  }
}
