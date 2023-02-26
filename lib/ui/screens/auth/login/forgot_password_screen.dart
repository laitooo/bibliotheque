import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/screens/auth/login/otp_code_screen.dart';
import 'package:bibliotheque/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: MainButton(
          title: "Continue",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const OtpCodeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
