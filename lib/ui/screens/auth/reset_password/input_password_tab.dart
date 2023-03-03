import 'package:bibliotheque/blocs/forget_password_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputPasswordTab extends StatefulWidget {
  const InputPasswordTab({Key? key}) : super(key: key);

  @override
  State<InputPasswordTab> createState() => _InputPasswordTabState();
}

class _InputPasswordTabState extends State<InputPasswordTab> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                  AppPasswordTextField(
                    label: "Password",
                    initialValue: "password",
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  AppPasswordTextField(
                    label: "Password",
                    initialValue: "password",
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: MainButton(
          title: "Continue",
          onPressed: () {
            BlocProvider.of<ForgetPasswordBloc>(context).add(
              InputNewPassword(
                password: passwordController.text,
                confirmPassword: confirmPasswordController.text,
              ),
            );
          },
        ),
      ),
    );
  }
}
