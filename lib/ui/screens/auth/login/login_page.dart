import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          children: [
            Text("Hello there",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: context.theme.textColor1,
            ),),
            const SizedBox(height: 20),
            Text("Please enter your username/email and password to sign in",
              style: TextStyle(
                fontSize: 14,
                color: context.theme.textColor3,
              ),),
          ],
        ),
      ),
    );
  }
}
