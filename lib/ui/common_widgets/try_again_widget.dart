import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.g.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:flutter/material.dart';

class TryAgainWidget extends StatelessWidget {
  final Function onPressed;

  const TryAgainWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).errors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/network_error.png',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 10),
          Text(
            t.networkError,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: context.theme.textColor1,
            ),
          ),
          const SizedBox(height: 16),
          MainButton(
            title: t.tryAgain,
            onPressed: () {
              onPressed.call();
            },
          )
        ],
      ),
    );
  }
}
