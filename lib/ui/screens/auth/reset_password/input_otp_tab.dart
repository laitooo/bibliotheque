import 'package:bibliotheque/blocs/forget_password_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputOtpTab extends StatefulWidget {
  const InputOtpTab({Key? key}) : super(key: key);

  @override
  State<InputOtpTab> createState() => _InputOtpTabState();
}

class _InputOtpTabState extends State<InputOtpTab> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
          builder: (context, state) {
            if (state.status == ForgetPasswordStatus.loading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: AppProgressIndicator(
                    size: 100,
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.auth.resetPassword.createPassword,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: context.theme.textColor1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    t.auth.resetPassword.enterNewPassword,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: context.theme.textColor5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      t.auth.resetPassword.notReceivedEmail,
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
                      t.auth.resetPassword.resendIn + "55 s",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: context.theme.textColor1,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: MainButton(
          title: t.auth.resetPassword.continu,
          onPressed: () {
            BlocProvider.of<ForgetPasswordBloc>(context).add(
              InputOtpCode(
                otp: otpController.text,
              ),
            );
          },
        ),
      ),
    );
  }
}
