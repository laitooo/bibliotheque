import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/screens/auth/login/forgot_password_screen.dart';
import 'package:bibliotheque/ui/screens/home/home_screen.dart';
import 'package:bibliotheque/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = true;

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
                "Hello there",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: context.theme.textColor1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Please enter your username/email and password to sign in.",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: context.theme.textColor5,
                ),
              ),
              const SizedBox(height: 40),
              AppTextField(
                label: "Username / Email",
                initialValue: "laitooo",
                controller: usernameEmailController,
              ),
              const SizedBox(height: 20),
              AppPasswordTextField(
                label: "Password",
                initialValue: "password",
                controller: passwordController,
              ),
              const SizedBox(height: 20),
              InkWell(
                child: Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: null,
                      fillColor: MaterialStateProperty.all(
                        context.theme.primaryColor,
                      ),
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(
                        fontSize: 14,
                        color: context.theme.textColor1,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    rememberMe = !rememberMe;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 20),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const ForgetPasswordScreen(),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: context.theme.textColor3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 0.5,
                      color: context.theme.dividerColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "or continue with",
                      style: TextStyle(
                        fontSize: 16,
                        color: context.theme.textColor5,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 0.5,
                      color: context.theme.dividerColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: context.theme.dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.language,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: context.theme.dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.language,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: context.theme.dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.language,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: MainButton(
          title: "Sign in",
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => HomeScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
