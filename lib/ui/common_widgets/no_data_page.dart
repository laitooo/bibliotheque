import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';

import 'buttons.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({
    Key? key,
    required this.text,
    required this.icon,
    this.subText,
    this.buttonText,
    this.onButtonClicked,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final String? subText;
  final String? buttonText;
  final Function? onButtonClicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              icon,
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
              const Spacer(),
              if (buttonText != null && onButtonClicked != null) Container(),
              if (buttonText != null && onButtonClicked != null)
                MainButton(
                  title: buttonText!,
                  removePadding: true,
                  onPressed: () {
                    onButtonClicked!.call();
                  },
                ),
              if (buttonText != null && onButtonClicked != null)
                const SizedBox(
                  height: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
