import 'package:bibliotheque/blocs/theme_bloc.dart';
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
          Icons.headset,
          () {},
        ),
        _mediaItem(
          context,
          'WhatsApp',
          Icons.headset,
          () {},
        ),
        _mediaItem(
          context,
          'Website',
          Icons.headset,
          () {},
        ),
        _mediaItem(
          context,
          'Facebook',
          Icons.headset,
          () {},
        ),
        _mediaItem(
          context,
          'Twitter',
          Icons.headset,
          () {},
        ),
        _mediaItem(
          context,
          'Instagram',
          Icons.headset,
          () {},
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  _mediaItem(BuildContext context, String name, IconData iconData,
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
            Icon(
              iconData,
              color: context.theme.primaryColor,
              size: 16,
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
