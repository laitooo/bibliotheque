import 'package:bibliotheque/blocs/notifications_options_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/screens/settings/change_language_page.dart';
import 'package:bibliotheque/ui/screens/settings/notification_preferences_screen.dart';
import 'package:bibliotheque/ui/screens/settings/payment_methods_screen.dart';
import 'package:bibliotheque/ui/screens/settings/user_profile_screen.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    const SizedBox(height: 20),
                    Text(
                      'Andrew_ainsley@yourdomain.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: context.theme.textColor5,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Icons.edit,
                  color: context.theme.iconColor1,
                  size: 20,
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
            "Payment methods",
            Icons.payment,
            const PaymentMethodScreen(),
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
            Icons.supervised_user_circle_sharp,
            const UserProfilePage(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "Notification",
            Icons.notifications,
            BlocProvider(
              create: (_) =>
                  NotificationsOptionsBloc()..add(LoadNotificationsOptions()),
              child: const NotificationPreferencesScreen(),
            ),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "Preferences",
            Icons.settings,
            const ChangeLanguagePage(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "Security",
            Icons.security,
            const ChangeLanguagePage(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "Language",
            Icons.language,
            const ChangeLanguagePage(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "DarkMode",
            Icons.remove_red_eye_sharp,
            const ChangeLanguagePage(),
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
            Icons.help,
            const ChangeLanguagePage(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "About the app",
            Icons.info,
            const ChangeLanguagePage(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            "Logout",
            Icons.logout,
            const ChangeLanguagePage(),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  _settingsItem(
      BuildContext context, String title, IconData iconData, Widget newScreen) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => newScreen),
        );
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: context.theme.iconBackgroundColor,
            ),
            child: Icon(
              iconData,
              size: 25,
              color: Colors.blue,
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
    );
  }
}
