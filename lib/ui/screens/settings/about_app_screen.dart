import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/svg.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.account.about.aboutAppName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          const SizedBox(height: 15),
          Center(
            child: Icon(
              Icons.menu_book,
              size: 200,
              color: context.theme.primaryColor,
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              "${t.appname} v1.2.5",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: context.theme.textColor1,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: context.theme.dividerColor,
              thickness: 0.5,
            ),
          ),
          _mediaLink(
            context,
            t.account.about.fees,
            'https://laitooo.vercel.app',
          ),
          _mediaLink(
            context,
            t.account.about.developer,
            'https://laitooo.vercel.app',
          ),
          _mediaLink(
            context,
            t.account.about.partner,
            'https://laitooo.vercel.app',
          ),
          _mediaLink(
            context,
            t.account.about.accessibility,
            'https://laitooo.vercel.app',
          ),
          _mediaLink(
            context,
            t.account.about.feedback,
            'https://laitooo.vercel.app',
          ),
          _mediaLink(
            context,
            t.account.about.rateUs,
            'https://laitooo.vercel.app',
          ),
          _mediaLink(
            context,
            t.account.about.visitOurWebsite,
            'https://laitooo.vercel.app',
          ),
          _mediaLink(
            context,
            t.account.about.followSocialMedia,
            'https://laitooo.vercel.app',
          ),
        ],
      ),
    );
  }

  _mediaLink(BuildContext context, String title, String url) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
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
}
