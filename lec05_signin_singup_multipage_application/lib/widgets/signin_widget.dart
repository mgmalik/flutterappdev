import 'package:flutter/material.dart';
import 'package:lec05_signin_singup_multipage_application/models/home_model.dart';
import 'package:lec05_signin_singup_multipage_application/pages/singup_page.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/change_widget.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SigninWidget extends StatelessWidget {
  const SigninWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.signInUser,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final Function signInUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextfieldWidget(
          hintText: 'Email',
          obscureText: false,
          prefixIconData: Icons.mail_outline,
          color: Colors.indigo,
          suffixIconData: null,
          isValid: context.watch<HomeModel>().isValidEmail,
          onChanged: (value) {
            // verify email...
            context.read<HomeModel>().verifyEmail(value);
          },
          controller: emailController,
          focusNode: emailFocusNode,
          onSubmitted: (value) {
            FocusScope.of(context).requestFocus(passwordFocusNode);
          },
        ),
        SizedBox(height: 10.0),
        TextfieldWidget(
          hintText: 'Password',
          obscureText: context.watch<HomeModel>().isVisible ? false : true,
          prefixIconData: Icons.lock_outline,
          color: Colors.indigo,
          isValid: context.watch<HomeModel>().isValidPassword,
          suffixIconData: context.watch<HomeModel>().isVisible
              ? Icons.visibility
              : Icons.visibility_off,
          onChanged: (value) {
            // may apply the rules for password selection
            context.read<HomeModel>().verifyPassword(value);
          },
          controller: passwordController,
          focusNode: passwordFocusNode,
          onSubmitted: (value) {
            signInUser();
          },
        ),
        SizedBox(height: 10.0),
        ChangeWidget(
          title: 'Signup',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (context) => const SignupPage()),
            );
          },
        ),
      ],
    );
  }
}
