import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:flutter/material.dart';

import 'buttons.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    Key? key,
    required this.text,
    required this.isPage,
    this.subText,
    this.buttonText,
    this.onButtonClicked,
  })  : assert((buttonText == null && onButtonClicked == null) ||
            (buttonText != null && onButtonClicked != null)),
        super(key: key);

  final bool isPage;
  final String text;
  final String? subText;
  final String? buttonText;
  final Function? onButtonClicked;

  @override
  Widget build(BuildContext context) {
    return isPage ? _emptyListPage(context) : _emptyListWidget(context);
  }

  _emptyListPage(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Svg(
                'empty_page.svg',
                size: 200,
                color: context.theme.iconColor2,
              ),
              const SizedBox(height: 90),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.theme.textColor1,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (subText != null) ...[
                const SizedBox(height: 16),
                Text(
                  subText!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.theme.textColor1,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: buttonText == null
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: MainButton(
                title: buttonText!,
                removePadding: true,
                onPressed: () {
                  onButtonClicked!.call();
                },
              ),
            ),
    );
  }

  _emptyListWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Svg(
            'empty_page.svg',
            size: 200,
            color: context.theme.iconColor2,
          ),
          const SizedBox(height: 90),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.theme.textColor1,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subText != null) ...[
            const SizedBox(height: 16),
            Text(
              subText!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.theme.textColor1,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
          if (buttonText != null) ...[
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: MainButton(
                title: buttonText!,
                removePadding: true,
                onPressed: () {
                  onButtonClicked!.call();
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}
