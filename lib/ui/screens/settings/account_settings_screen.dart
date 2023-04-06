import 'package:bibliotheque/blocs/notifications_options_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/settings/about_app_screen.dart';
import 'package:bibliotheque/ui/screens/settings/change_language_page.dart';
import 'package:bibliotheque/ui/screens/settings/help/help_center_screen.dart';
import 'package:bibliotheque/ui/screens/settings/logout_bottom_sheet.dart';
import 'package:bibliotheque/ui/screens/settings/notification_preferences_screen.dart';
import 'package:bibliotheque/ui/screens/settings/payment_methods_screen.dart';
import 'package:bibliotheque/ui/screens/settings/user_profile_screen.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: context.theme.textColor1,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Svg(
              'more.svg',
              size: 28,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: [
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const UserProfilePage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      generator.avatar(),
                    ),
                    radius: 30,
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Andrew Ainsley',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: context.theme.textColor1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Andrew_ainsley@yourdomain.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: context.theme.textColor1,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Svg(
                    'edit_account.svg',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          const SizedBox(height: 15),
          _settingsItem(
            context,
            "Payment methods",
            "wallet.svg",
            Colors.green,
            newScreen: const PaymentMethodScreen(),
          ),
          const SizedBox(height: 15),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          const SizedBox(height: 15),
          _settingsItem(
            context,
            "Personal Info",
            "account_created.svg",
            Colors.lightBlue,
            newScreen: const UserProfilePage(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "Notification",
            "notifications_settings.svg",
            Colors.pinkAccent,
            newScreen: BlocProvider(
              create: (_) =>
                  NotificationsOptionsBloc()..add(LoadNotificationsOptions()),
              child: const NotificationPreferencesScreen(),
            ),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "Language",
            "grid_view.svg",
            Colors.orangeAccent,
            newScreen: const ChangeLanguagePage(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blueAccent.withOpacity(0.1),
                  ),
                  child: const Svg(
                    "dark_mode.svg",
                    size: 25,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 20),
                Center(
                  child: Text(
                    "Night mode",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: context.theme.textColor1,
                    ),
                  ),
                ),
                const Spacer(),
                Switch(
                  activeColor: context.theme.activeColor,
                  value: prefs.isNightMode() ?? false,
                  onChanged: (newVal) {
                    BlocProvider.of<ThemeBloc>(context).add(LoadTheme(true));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          const SizedBox(height: 15),
          _settingsItem(
            context,
            "Help center",
            "wishlist_active.svg",
            Colors.green,
            newScreen: const HelpCenterScreen(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "About the app",
            "about.svg",
            Colors.orange,
            newScreen: const AboutAppScreen(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "Logout",
            'logout.svg',
            Colors.redAccent,
            onClick: () {
              onLogoutCLicked(context);
            },
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  _settingsItem(BuildContext context, String title, String svgPath, Color color,
      {Widget? newScreen, void Function()? onClick}) {
    return InkWell(
      onTap: () {
        if (newScreen != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => newScreen),
          );
        } else {
          if (onClick != null) {
            onClick();
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: color.withOpacity(0.1),
              ),
              child: Svg(
                svgPath,
                size: 25,
                color: color,
              ),
            ),
            const SizedBox(width: 20),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.theme.textColor1,
                ),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_sharp,
              color: context.theme.iconColor1,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void onLogoutCLicked(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.theme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => const LogoutBottomSheet(),
    );
  }
}
