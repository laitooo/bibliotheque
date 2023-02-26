import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/screens/auth/login/reset_password_success_dialog.dart';
import 'package:flutter/material.dart';

class OtpCodeScreen extends StatefulWidget {
  const OtpCodeScreen({Key? key}) : super(key: key);

  @override
  State<OtpCodeScreen> createState() => _OtpCodeScreenState();
}

class _OtpCodeScreenState extends State<OtpCodeScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create new password",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: context.theme.textColor1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Enter your new password. If you forget it, then you have to forget password.",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: context.theme.textColor5,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  "Didn't receive email?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textColor1,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "You can resend code in 55 s",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: context.theme.textColor1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: MainButton(
          title: "Confirm",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const ResetPasswordSuccessDialog(),
              useRootNavigator: false,
            );
          },
        ),
      ),
    );
  }
}
