import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/utils/locale_date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        // height: 94,
        padding: const EdgeInsetsDirectional.fromSTEB(32, 19, 38, 0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  notificationAsset(notification.event.type),
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 10),
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
      default:
        return "assets/icons/scheduled_order.svg";
    }
  }
}
