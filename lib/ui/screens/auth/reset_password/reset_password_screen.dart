import 'package:bibliotheque/blocs/forget_password_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/app_snackbar.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/auth/reset_password/input_email_tab.dart';
import 'package:bibliotheque/ui/screens/auth/reset_password/input_otp_tab.dart';
import 'package:bibliotheque/ui/screens/auth/reset_password/input_password_tab.dart';
import 'package:bibliotheque/ui/dialogs/reset_password_success_dialog.dart';
import 'package:bibliotheque/utils/enum_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetPasswordBloc(),
      child: const _ResetPasswordScreen(),
    );
  }
}

class _ResetPasswordScreen extends StatefulWidget {
  const _ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<_ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<_ResetPasswordScreen> {
  final controller = PageController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Container(),
        leading: IconButton(
          icon: const Svg('back.svg'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
        listener: (context, state) async {
          if (state.status == ForgetPasswordStatus.success) {
            await showDialog(
              context: context,
              builder: (context) => const ResetPasswordSuccessDialog(),
              useRootNavigator: false,
            );
            Navigator.of(context).pop();
          }

          if (state.status == ForgetPasswordStatus.error) {
            context.showSnackBar(
              text: forgetPasswordErrorToText(state.error!),
            );
          }

          setState(() {
            current = resetPasswordProcessToInt(state.process);
            controller.jumpToPage(current);
          });
        },
        builder: (context, state) {
          return PageView(
            controller: controller,
            reverse: false,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (newPage) {
              setState(() {
                current = newPage;
              });
            },
            children: [
              BlocProvider.value(
                value: BlocProvider.of<ForgetPasswordBloc>(context),
                child: const InputEmailTab(),
              ),
              BlocProvider.value(
                value: BlocProvider.of<ForgetPasswordBloc>(context),
                child: const InputOtpTab(),
              ),
              BlocProvider.value(
                value: BlocProvider.of<ForgetPasswordBloc>(context),
                child: const InputPasswordTab(),
              ),
            ],
          );
        },
      ),
    );
  }

  resetPasswordProcessToInt(ForgetPasswordProcess process) {
    switch (process) {
      case ForgetPasswordProcess.inputEmail:
        return 0;
      case ForgetPasswordProcess.inputOtp:
        return 1;
      case ForgetPasswordProcess.inputNewPassword:
        return 2;
    }
  }
}
