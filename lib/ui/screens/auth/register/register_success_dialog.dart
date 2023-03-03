import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class RegisterSuccessDialog extends StatefulWidget {
  const RegisterSuccessDialog({Key? key}) : super(key: key);

  @override
  State<RegisterSuccessDialog> createState() => _RegisterSuccessDialogState();
}

class _RegisterSuccessDialogState extends State<RegisterSuccessDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ),
      );
    });
  }

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
              horizontal: 60,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
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
                  child: Svg("account_created.svg",
                  size: 40,
                  color: context.theme.iconColor3,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "Sign Up Successful",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: context.theme.textColor3),
                ),
                const SizedBox(height: 20),
                Text(
                  "Your account has been created. Please wait a moment, we are preparing for you...",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 14, color: context.theme.textColor5),
                ),
                const SizedBox(height: 20),
                const AppProgressIndicator(size: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
