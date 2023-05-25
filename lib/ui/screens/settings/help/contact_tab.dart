import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:flutter/material.dart';

class ContactTab extends StatelessWidget {
  const ContactTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: [
        const SizedBox(height: 10),
        _mediaItem(
          context,
          t.account.help.customerService,
          'call_center.svg',
          () {},
        ),
        _mediaItem(
          context,
          t.account.help.whatsapp,
          'whatsapp.svg',
          () {},
        ),
        _mediaItem(
          context,
          t.account.help.website,
          'website.svg',
          () {},
        ),
        _mediaItem(
          context,
          t.account.help.facebook,
          'facebook2.svg',
          () {},
        ),
        _mediaItem(
          context,
          t.account.help.twitter,
          'twitter.svg',
          () {},
        ),
        _mediaItem(
          context,
          t.account.help.instagram,
          'instagram.svg',
          () {},
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  _mediaItem(BuildContext context, String name, String svgPath,
      void Function() onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Svg(
              svgPath,
              size: 24,
              matchTextDirection: false,
              color: context.theme.primaryColor,
            ),
            const SizedBox(width: 20),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: context.theme.textColor1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
