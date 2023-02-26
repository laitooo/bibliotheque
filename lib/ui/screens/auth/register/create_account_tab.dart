import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/widgets/input_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

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
            "Create an account",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: context.theme.textColor1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Enter your username, email & password. If you forget it, then you have to do forget password.",
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: context.theme.textColor5,
            ),
          ),
          const SizedBox(height: 40),
          AppTextField(
            label: "Username",
            initialValue: "laitooo",
            controller: usernameController,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: "Email",
            initialValue: "alziber50@gmail.com",
            controller: emailController,
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          AppPasswordTextField(
            label: "Password",
            initialValue: "password",
            controller: passwordController,
          ),
          const SizedBox(height: 20),
          AppPasswordTextField(
            label: "Confirm password",
            initialValue: "password",
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
        ],
      ),
    );
  }
}
