import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:flutter/material.dart';

class CreatedReviewSuccessDialog extends StatefulWidget {
  const CreatedReviewSuccessDialog({Key? key}) : super(key: key);

  @override
  State<CreatedReviewSuccessDialog> createState() =>
      _CreatedReviewSuccessDialogState();
}

class _CreatedReviewSuccessDialogState
    extends State<CreatedReviewSuccessDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 40.0,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            decoration: BoxDecoration(
              color: context.theme.backgroundColor,
              borderRadius: BorderRadius.circular(38.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Svg(
                    "account_created.svg",
                    size: 40,
                    color: context.theme.iconColor3,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  t.createReview.successTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: context.theme.textColor3,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  t.createReview.successContent,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.theme.textColor4,
                  ),
                ),
                const SizedBox(height: 30),
                MainButton(
                  title: t.createReview.ok,
                  textColor: context.theme.textColor2,
                  backgroundColor: context.theme.buttonColor1,
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
