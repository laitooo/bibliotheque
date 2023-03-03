import 'package:bibliotheque/blocs/forget_password_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/screens/auth/register/register_success_dialog.dart';
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
    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) async {
        if (state.status == ForgetPasswordStatus.success) {
          await showDialog(
            context: context,
            builder: (context) => const RegisterSuccessDialog(),
            useRootNavigator: false,
          );
          Navigator.of(context).pop();
        }

        if (state.status == ForgetPasswordStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Network error",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: context.theme.textColor1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Enter your email address. We will send an OTP code for verification in the next step.",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: context.theme.textColor5,
                ),
              ),
              const SizedBox(height: 40),
              AppTextField(
                label: "Email",
                initialValue: "andrew.ainsley@yourdomain.com",
                controller: emailController,
              ),
              const SizedBox(height: 20),
              const Spacer(),
              MainButton(
                title: "Continue",
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
