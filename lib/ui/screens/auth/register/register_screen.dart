import 'package:bibliotheque/blocs/categories_bloc.dart';
import 'package:bibliotheque/blocs/register_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/screens/auth/register/age_tab.dart';
import 'package:bibliotheque/ui/screens/auth/register/categories_tab.dart';
import 'package:bibliotheque/ui/screens/auth/register/complete_profile_tab.dart';
import 'package:bibliotheque/ui/screens/auth/register/create_account_tab.dart';
import 'package:bibliotheque/ui/screens/auth/register/gender_tab.dart';
import 'package:bibliotheque/ui/screens/auth/register/register_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(),
      child: const _RegisterPage(),
    );
  }
}

class _RegisterPage extends StatefulWidget {
  const _RegisterPage({Key? key}) : super(key: key);

  @override
  State<_RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<_RegisterPage> {
  final controller = PageController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Container(),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          if (state.status == RegisterStatus.success) {
            await showDialog(
              context: context,
              builder: (context) => const RegisterSuccessDialog(),
              useRootNavigator: false,
            );
            Navigator.of(context).pop();
          }

          if (state.status == RegisterStatus.error) {
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

          setState(() {
            current = registerProcessToInt(state.process);
            controller.jumpToPage(current);
          });
        },
        builder: (context, state) {
          // TODO: maybe handle the auth processes loading ui better
          // Maybe even use a loading dialog
          if (state.status == RegisterStatus.loading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: AppProgressIndicator(
                  size: 100,
                ),
              ),
            );
          }

          return PageView(
            controller: controller,
            reverse: false,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (newPage) {
              setState(() {
                current = newPage;
              });
            },
            children: [
              BlocProvider.value(
                value: BlocProvider.of<RegisterBloc>(context),
                child: const GenderTab(),
              ),
              BlocProvider.value(
                value: BlocProvider.of<RegisterBloc>(context),
                child: const AgeTab(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => CategoriesBloc()
                      ..add(
                        LoadCategories(allCategories: true),
                      ),
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<RegisterBloc>(context),
                  ),
                ],
                child: const CategoriesTab(),
              ),
              BlocProvider.value(
                value: BlocProvider.of<RegisterBloc>(context),
                child: const CompleteProfileTab(),
              ),
              BlocProvider.value(
                value: BlocProvider.of<RegisterBloc>(context),
                child: const CreateAccountTab(),
              ),
            ],
          );
        },
      ),
    );
  }

  registerProcessToInt(RegisterProcess process) {
    switch (process) {
      case RegisterProcess.gender:
        return 0;
      case RegisterProcess.age:
        return 1;
      case RegisterProcess.categories:
        return 2;
      case RegisterProcess.profile:
        return 3;
      case RegisterProcess.account:
        return 4;
    }
  }
}
