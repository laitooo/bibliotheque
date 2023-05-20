import 'package:bibliotheque/blocs/register_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/widgets/input_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountTab extends StatefulWidget {
  const CreateAccountTab({Key? key}) : super(key: key);

  @override
  State<CreateAccountTab> createState() => _CreateAccountTabState();
}

class _CreateAccountTabState extends State<CreateAccountTab> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  DateTime birthDay = DateTime(2000);
  Country country = Country.parse("sd");
  bool rememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.auth.register.createAccount,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: context.theme.textColor1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            t.auth.register.enterUsernameEmailAndPassword,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: context.theme.textColor4,
            ),
          ),
          const SizedBox(height: 40),
          AppTextField(
            label: t.auth.register.username,
            initialValue: "",
            controller: usernameController,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: t.auth.register.email,
            initialValue: "",
            controller: emailController,
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          AppPasswordTextField(
            label: t.auth.register.password,
            initialValue: "",
            controller: passwordController,
          ),
          const SizedBox(height: 20),
          AppPasswordTextField(
            label: t.auth.register.confirmPassword,
            initialValue: "",
            controller: passwordConfirmController,
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
                  t.auth.register.rememberMe,
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
          const SizedBox(height: 20),
          const Spacer(),
          MainButton(
            title: t.auth.register.signUp,
            removePadding: true,
            onPressed: () {
              BlocProvider.of<RegisterBloc>(context).add(
                SignUp(
                  email: emailController.text,
                  password: passwordController.text,
                  passwordConfirm: passwordConfirmController.text,
                  username: usernameController.text,
                  rememberMe: rememberMe,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
