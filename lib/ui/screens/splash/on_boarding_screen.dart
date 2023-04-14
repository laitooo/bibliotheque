import 'package:bibliotheque/blocs/google_auth_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/screens/auth/login/login_screen.dart';
import 'package:bibliotheque/ui/screens/auth/register/register_screen.dart';
import 'package:bibliotheque/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GoogleAuthBloc(),
      child: const _OnBoardingScreen(),
    );
  }
}

class _OnBoardingScreen extends StatefulWidget {
  const _OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<_OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<_OnBoardingScreen> {
  int current = 0;
  final controller = PageController();

  @override
  void initState() {
    super.initState();
    // TODO:: uncomment when finished
    // prefs.setIsFirstTimer(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
        listener: (context, state) {
          if (state.status == GoogleAuthStatus.success) {
            _loginSuccess();
          }

          if (state.status == GoogleAuthStatus.error) {
            // TODO:: use real errors instead of always network error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  t.errors.networkError,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == GoogleAuthStatus.loading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: AppProgressIndicator(
                  size: 100,
                ),
              ),
            );
          }

          return Stack(
            children: [
              PageView(
                controller: controller,
                reverse: false,
                onPageChanged: (newPage) {
                  setState(() {
                    current = newPage;
                  });
                },
                children: List.generate(
                  3,
                  (index) => Column(
                    children: [
                      SizedBox(
                        child: Image.network(
                          "https://julianstodd.files.wordpress.com/2016/03/img_3419.jpg?w=640&h=853",
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: t.onBoarding.welcomeTo,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: context.theme.textColor1,
                              ),
                            ),
                            TextSpan(
                              text: t.appname,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: context.theme.textColor3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          t.onBoarding.numberOne,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: 16,
                            color: context.theme.textColor1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _DotIndicator(page: current),
                    const SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: context.theme.googleButtonBackgroundColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          width: 0.5,
                          color: context.theme.dividerColor,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<GoogleAuthBloc>(context).add(
                            ContinueWithGoogle(),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.language,
                              size: 20,
                              color: context.theme.primaryColor,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              t.onBoarding.continueWithGoogle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: context.theme.textColor1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    MainButton(
                      title: t.onBoarding.getStarted,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    MainFlatButton(
                      title: t.onBoarding.alreadyHaveACcount,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _loginSuccess() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomeScreen(),
      ),
    );
  }
}

class _DotIndicator extends StatelessWidget {
  final int page;

  const _DotIndicator({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          width: page == index ? 28 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: page == index
                ? context.theme.activeColor
                : context.theme.inActiveColor,
          ),
        ),
      ),
    );
  }
}
