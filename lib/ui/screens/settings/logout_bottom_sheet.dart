import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/repos/auth_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/screens/splash/on_boarding_screen.dart';
import 'package:flutter/material.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Column(
        children: [
          const SizedBox(height: 6),
          Center(
            child: Container(
              width: 40,
              height: 3,
              color: context.theme.dividerColor.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            t.account.logout.title,
            style: TextStyle(
              color: context.theme.textColor6,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 0.5,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            t.account.logout.areYouSure,
            style: TextStyle(
              color: context.theme.textColor1,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: MainButton(
                  title: t.account.logout.title,
                  textColor: context.theme.textColor2,
                  backgroundColor: context.theme.buttonColor1,
                  removePadding: true,
                  onPressed: () async {
                    final auth = serviceLocator<AuthRepository>();
                    await auth.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const OnBoardingScreen(),
                      ),
                      (_) => false,
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: MainFlatButton(
                  title: t.account.logout.cancel,
                  removePadding: true,
                  textColor: context.theme.textColor3,
                  backgroundColor: context.theme.buttonColor2,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
