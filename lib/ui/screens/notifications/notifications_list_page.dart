import 'package:bibliotheque/blocs/notifications_bloc.dart';
import 'package:bibliotheque/models/notification.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/no_data_page.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsListPage extends StatefulWidget {
  const NotificationsListPage({Key? key}) : super(key: key);

  @override
  _NotificationsListPageState createState() => _NotificationsListPageState();
}

class _NotificationsListPageState extends State<NotificationsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
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

          if (state.notifications!.isNotEmpty) {
            return NoDataPage(
              text: "Empty",
              subText: "You don't have any notifications at this time",
              icon: SvgPicture.asset(
                'assets/images/no_notifications.svg',
                width: 300,
                height: 200,
              ),
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
