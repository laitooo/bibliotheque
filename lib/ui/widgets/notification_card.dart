import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/utils/locale_date_format.dart';
import 'package:flutter/material.dart';
import 'package:bibliotheque/models/notification.dart' as nt;

class NotificationCard extends StatelessWidget {
  final nt.Notification notification;
  final bool isLastItem;
  final Function()? onClick;

  const NotificationCard({
    Key? key,
    required this.notification,
    this.isLastItem = false,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = LocaleDateFormat();
    bool isArabic = Localizations.localeOf(context).languageCode == "ar";

    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: notificationIconColor(notification.event.type)
                          .withOpacity(0.1)),
                  child: Svg(
                    notificationAsset(notification.event.type),
                    size: 20,
                    color: notificationIconColor(notification.event.type),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        isArabic ? notification.titleAr : notification.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: context.theme.textColor1,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      // TODO: date time format for the whole app
                      const SizedBox(height: 8),
                      Text(
                        formatter.defaultFormat(notification.date),
                        maxLines: 1,
                        style: TextStyle(
                          color: context.theme.textColor4,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                if (notification.date.difference(DateTime.now()).inDays < 2)
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "New",
                      style: TextStyle(
                        fontSize: 12,
                        color: context.theme.textColor2,
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                isArabic ? notification.bodyAr : notification.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: context.theme.textColor4,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String notificationAsset(nt.NotificationType type) {
    switch (type) {
      case nt.NotificationType.newUpdateAvailable:
      case nt.NotificationType.securityUpdates:
        return "success.svg";
      case nt.NotificationType.multipleCardFeatures:
        return "grid.svg";
      case nt.NotificationType.creditCardConnected:
        return "wallet.svg";
      default:
        return "account_created.svg";
    }
  }

  Color notificationIconColor(nt.NotificationType type) {
    switch (type) {
      case nt.NotificationType.newUpdateAvailable:
        return Colors.deepPurpleAccent;
      case nt.NotificationType.securityUpdates:
        return Colors.blueAccent;
      case nt.NotificationType.multipleCardFeatures:
        return Colors.orangeAccent;
      case nt.NotificationType.creditCardConnected:
        return Colors.deepPurple;
      default:
        return Colors.green;
    }
  }
}
