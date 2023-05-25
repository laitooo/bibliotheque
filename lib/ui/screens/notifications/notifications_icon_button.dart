import 'package:bibliotheque/blocs/notifications_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/blocs/unread_notifications_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/notifications/notifications_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsIconButton extends StatelessWidget {
  const NotificationsIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.theme.backgroundColor,
      radius: 24.0,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              final bloc = context.read<UnreadNotificationsBloc>();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (_) => NotificationsListBloc()
                            ..add(
                              LoadNotificationsList(),
                            ),
                        ),
                        BlocProvider.value(value: bloc)
                      ],
                      child: const NotificationsListScreen(),
                    );
                  },
                ),
              );
            },
            child: Center(
              child: Svg(
                "notifications.svg",
                size: 24,
                color: context.theme.iconColor1,
              ),
            ),
          ),
          PositionedDirectional(
            start: 14,
            top: 14,
            child:
                BlocBuilder<UnreadNotificationsBloc, UnreadNotificationsState>(
              builder: (context, state) {
                if (state.status == UnreadNotificationsStatus.success) {
                  if (state.hasNotification!) {
                    return Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: context.theme.primaryColor,
                      ),
                    );
                  }
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
