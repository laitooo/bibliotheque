import 'package:bibliotheque/blocs/theme_bloc.dart';
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
        // TODO:: complete this
        _mediaItem(
          context,
          'Customer service',
          'call_center.svg',
          () {},
        ),
        _mediaItem(
          context,
          'WhatsApp',
          'whatsapp.svg',
          () {},
        ),
        _mediaItem(
          context,
          'Website',
          'website.svg',
          () {},
        ),
        _mediaItem(
          context,
          'Facebook',
          'facebook.svg',
          () {},
        ),
        _mediaItem(
          context,
          'Twitter',
          'twitter.svg',
          () {},
        ),
        _mediaItem(
          context,
          'Instagram',
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
              color: context.theme.primaryColor,
              size: 24,
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
