import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as fsvg;

import '../../../i18n/translations.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.account.paymentMethod.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: context.theme.textColor1,
          ),
        ),
        leading: IconButton(
          icon: const Svg('back.svg'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Svg(
              'more.svg',
              size: 28,
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        children: [
          const SizedBox(height: 15),
          _paymentMethod(
            context,
            t.account.paymentMethod.paypal,
            "paypal.svg",
            false,
            () {},
          ),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          _paymentMethod(
            context,
            t.account.paymentMethod.google,
            "google.svg",
            false,
            () {},
          ),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          _paymentMethod(
            context,
            t.account.paymentMethod.apple,
            "apple.svg",
            true,
            () {},
          ),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          _paymentMethod(
            context,
            t.account.paymentMethod.visa,
            "visa.svg",
            true,
            () {},
          ),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          _paymentMethod(
            context,
            t.account.paymentMethod.master,
            "mastercard.svg",
            false,
            () {},
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  _paymentMethod(BuildContext context, String title, String svgPath,
      bool nightModeColor, void Function() onClick) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            fsvg.SvgPicture.asset(
              "assets/icons/" + svgPath,
              width: 50,
              height: 50,
              color: nightModeColor ? context.theme.iconColor1 : null,
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
}
