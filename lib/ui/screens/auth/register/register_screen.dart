import 'package:bibliotheque/blocs/categories_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/screens/auth/register/age_tab.dart';
import 'package:bibliotheque/ui/screens/auth/register/categories_tab.dart';
import 'package:bibliotheque/ui/screens/auth/register/complete_profile_tab.dart';
import 'package:bibliotheque/ui/screens/auth/register/create_account_tab.dart';
import 'package:bibliotheque/ui/screens/auth/register/gender_tab.dart';
import 'package:bibliotheque/ui/screens/auth/register/register_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = PageController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(),
      ),
      body: PageView(
        controller: controller,
        reverse: false,
        onPageChanged: (newPage) {
          setState(() {
            current = newPage;
          });
        },
        children: [
          const GenderTab(),
          const AgeTab(),
          BlocProvider(
            create: (_) => CategoriesBloc()
              ..add(
                LoadCategories(allCategories: true),
              ),
            child: const CategoriesTab(),
          ),
          const CompleteProfileTab(),
          const CreateAccountTab(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: current == 2
            ? Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                    child: MainButton(
                      title: "Continue",
                      textColor: context.theme.textColor2,
                      backgroundColor: context.theme.buttonColor1,
                      removePadding: true,
                      onPressed: () async {
                        // TODO:: complete this
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: MainFlatButton(
                      title: "Skip",
                      removePadding: true,
                      textColor: context.theme.textColor3,
                      backgroundColor: context.theme.buttonColor2,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              )
            : MainButton(
                title: current != 4 ? "Continue" : "Sign up",
                onPressed: () {
                  if (current == 4) {
                    showDialog(
                      context: context,
                      builder: (context) => const RegisterSuccessDialog(),
                      useRootNavigator: false,
                    );
                  }
                },
              ),
      ),
    );
  }
}
