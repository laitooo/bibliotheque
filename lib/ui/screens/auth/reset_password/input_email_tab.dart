import 'package:bibliotheque/blocs/forget_password_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputEmailTab extends StatefulWidget {
  const InputEmailTab({Key? key}) : super(key: key);

  @override
  State<InputEmailTab> createState() => _InputEmailTabState();
}

class _InputEmailTabState extends State<InputEmailTab> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
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
                t.auth.resetPassword.forgotPassword,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: context.theme.textColor1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                t.auth.resetPassword.enterEmail,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: context.theme.textColor5,
                ),
              ),
              const SizedBox(height: 40),
              AppTextField(
                label: t.auth.resetPassword.email,
                initialValue: "andrew.ainsley@yourdomain.com",
                controller: emailController,
              ),
              const SizedBox(height: 20),
              const Spacer(),
              MainButton(
                title: t.auth.resetPassword.continu,
                removePadding: true,
                onPressed: () {
                  BlocProvider.of<ForgetPasswordBloc>(context).add(
                    InputEmail(
                      email: emailController.text,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
