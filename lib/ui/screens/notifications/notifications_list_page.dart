import 'package:bibliotheque/blocs/notifications_bloc.dart';
import 'package:bibliotheque/blocs/notifications_options_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/models/notification.dart';
import 'package:bibliotheque/ui/common_widgets/try_again_widget.dart';
import 'package:bibliotheque/ui/common_widgets/empty_list_widget.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/screens/settings/notification_preferences_screen.dart';
import 'package:bibliotheque/ui/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';

class NotificationsListScreen extends StatefulWidget {
  const NotificationsListScreen({Key? key}) : super(key: key);

  @override
  _NotificationsListScreenState createState() =>
      _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.notifications.title,
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => NotificationsOptionsBloc()
                      ..add(LoadNotificationsOptions()),
                    child: const NotificationPreferencesScreen(),
                  ),
                ),
              );
            },
            icon: const Svg('settings.svg'),
          ),
        ],
      ),
      body: BlocBuilder<NotificationsListBloc, NotificationsListState>(
        builder: (context, state) {
          if (state.status == NotificationsListStatus.loading) {
            return const Center(child: AppProgressIndicator(size: 100));
          }

          if (state.status == NotificationsListStatus.error) {
            return TryAgainWidget(
              onPressed: () {
                BlocProvider.of<NotificationsListBloc>(context).add(
                  LoadNotificationsList(),
                );
              },
            );
          }

          if (state.notifications!.isEmpty) {
            return EmptyListWidget(
              text: t.notifications.empty,
              subText: t.notifications.noNotifications,
              isPage: false,
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: state.notifications!
                .map(
                  (notification) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: NotificationCard(
                      notification: notification,
                      onClick: () {
                        _onNotificationClicked(notification.event);
                      },
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  _onNotificationClicked(NotificationEvent event) {
    switch (event.type) {
      case NotificationType.creditCardConnected:
      case NotificationType.newUpdateAvailable:
      case NotificationType.multipleCardFeatures:
      case NotificationType.securityUpdates:
      case NotificationType.others:
      default:
        break;
    }
  }
}
