import 'package:bibliotheque/blocs/edit_profile_bloc.dart';
import 'package:bibliotheque/blocs/notifications_options_bloc.dart';
import 'package:bibliotheque/blocs/profile_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/circle_image_widget.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/settings/about_app_screen.dart';
import 'package:bibliotheque/ui/screens/settings/change_language_screen.dart';
import 'package:bibliotheque/ui/screens/settings/help/help_center_screen.dart';
import 'package:bibliotheque/ui/screens/settings/logout_bottom_sheet.dart';
import 'package:bibliotheque/ui/screens/settings/notification_preferences_screen.dart';
import 'package:bibliotheque/ui/screens/settings/payment_methods_screen.dart';
import 'package:bibliotheque/ui/screens/settings/profile/user_profile_screen.dart';
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../i18n/translations.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(LoadProfile()),
      child: const _AccountSettingsScreen(),
    );
  }
}

class _AccountSettingsScreen extends StatelessWidget {
  const _AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).account.account;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.title,
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
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return Column(
                children: [
                  if (state.status == ProfileStatus.loading)
                    const Center(
                      child: AppProgressIndicator(size: 60),
                    ),
                  if (state.status == ProfileStatus.success)
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: BlocProvider.of<ProfileBloc>(context),
                                ),
                                BlocProvider(create: (_) => EditProfileBloc())
                              ],
                              child: const UserProfileScreen(),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            CircleImageWidget(
                              state.profile!.avatarUrl,
                              size: 60,
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.profile!.fullName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: context.theme.textColor1,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.profile!.email,
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
                  if (state.status != ProfileStatus.error) ...[
                    const SizedBox(height: 15),
                    Divider(
                      thickness: 0.5,
                      color: context.theme.dividerColor,
                    ),
                    const SizedBox(height: 15),
                  ],
                ],
              );
            },
          ),
          _settingsItem(
            context,
            t.paymentMethod,
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
            t.personalInfo,
            "account_created.svg",
            Colors.lightBlue,
            newScreen: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: BlocProvider.of<ProfileBloc>(context),
                ),
                BlocProvider(create: (_) => EditProfileBloc())
              ],
              child: const UserProfileScreen(),
            ),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            t.notifications,
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
            t.language,
            "grid_view.svg",
            Colors.orangeAccent,
            newScreen: const ChangeLanguageScreen(),
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
                    t.nightMode,
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
            t.helpCenter,
            "wishlist_active.svg",
            Colors.green,
            newScreen: const HelpCenterScreen(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            t.aboutApp,
            "about.svg",
            Colors.orange,
            newScreen: const AboutAppScreen(),
          ),
          const SizedBox(height: 20),
          _settingsItem(
            context,
            t.logout,
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
