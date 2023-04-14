import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/screens/home/home_screen.dart';
import 'package:bibliotheque/ui/screens/splash/on_boarding_screen.dart';
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToNext(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/logo.png',
            //   width: 200,
            //   height: 200,
            // ),
            Icon(
              Icons.library_books,
              size: 200,
              color: context.theme.primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              t.appname,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: context.theme.textColor1,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void _goToNext(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) =>
                !prefs.isFirstTimer() ? const OnBoardingScreen() : const HomeScreen(),
          ),
        );
      },
    );
  }
}
