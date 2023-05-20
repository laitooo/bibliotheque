import 'package:bibliotheque/blocs/sign_in_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/app_snackbar.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/screens/auth/reset_password/reset_password_screen.dart';
import 'package:bibliotheque/ui/screens/home/home_screen.dart';
import 'package:bibliotheque/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInBloc(),
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatefulWidget {
  const _LoginScreen({Key? key}) : super(key: key);

  @override
  State<_LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginScreen> {
  TextEditingController usernameEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) async {
          if (state.status == SignInStatus.success) {
            _loginSuccess();
          }

          if (state.status == SignInStatus.error) {
            context.showSnackBar(
              text: t.errors.networkError,
            );
          }
        },
        builder: (context, state) {
          if (state.status == SignInStatus.loading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: AppProgressIndicator(
                  size: 100,
                ),
              ),
            );
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.auth.login.helloThere,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: context.theme.textColor1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    t.auth.login.pleaseEnterEmailPassword,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: context.theme.textColor5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  AppTextField(
                    label: t.auth.login.usernameEmail,
                    initialValue: "",
                    controller: usernameEmailController,
                  ),
                  const SizedBox(height: 20),
                  AppPasswordTextField(
                    label: t.auth.login.password,
                    initialValue: "",
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
                          t.auth.login.rememberMe,
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
                          builder: (_) => const ResetPasswordScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        t.auth.login.forgotPassword,
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
                          t.auth.login.orContinueWith,
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
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<SignInBloc>(context)
                                .add(GoogleSignIn());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: context.theme.dividerColor,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/google.svg",
                              width: 24,
                              height: 24,
                              matchTextDirection: false,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<SignInBloc>(context)
                                .add(AppleSignIn());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: context.theme.dividerColor,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/apple.svg",
                              width: 28,
                              height: 28,
                              matchTextDirection: false,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<SignInBloc>(context)
                                .add(FacebookSignIn());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: context.theme.dividerColor,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/facebook.svg",
                              width: 28,
                              height: 28,
                              matchTextDirection: false,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          if (state.status == SignInStatus.loading) {
            return const SizedBox();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: MainButton(
              title: t.auth.login.signIn,
              onPressed: () {
                BlocProvider.of<SignInBloc>(context).add(
                  SignIn(
                    usernameEmail: usernameEmailController.text,
                    password: passwordController.text,
                    rememberMe: rememberMe,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _loginSuccess() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }
}
