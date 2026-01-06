import 'package:flutter/material.dart';
import 'package:lec05_signin_singup_multipage_application/models/home_model.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/change_widget.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameFocusNode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.signUpUser,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode nameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final Function signUpUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextfieldWidget(
          hintText: 'Name',
          obscureText: false,
          prefixIconData: Icons.verified_user,
          color: Colors.indigo,
          suffixIconData: null,
          isValid: context.watch<HomeModel>().isValid,
          onChanged: (value) {
            // verify email...
            if (value.toString().length > 3) {
              context.read<HomeModel>().isValid = true;
            } else {
              context.read<HomeModel>().isValid = false;
            }
          },
          controller: nameController,
          focusNode: nameFocusNode,
          onSubmitted: (value) {
            FocusScope.of(context).requestFocus(emailFocusNode);
          },
        ),
        SizedBox(height: 10.0),
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
            FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
          },
        ),
        SizedBox(height: 10.0),
        TextfieldWidget(
          hintText: 'Confirm Password',
          obscureText: context.watch<HomeModel>().isVisible ? false : true,
          prefixIconData: Icons.lock_outline,
          color: Colors.indigo,
          isValid: context.watch<HomeModel>().isValidConfirmPassword,
          suffixIconData: context.watch<HomeModel>().isVisible
              ? Icons.visibility
              : Icons.visibility_off,
          onChanged: (value) {
            // may apply the rules for password selection
            context.read<HomeModel>().verifyConfirmPassword(
              value,
              passwordController.text,
            );
          },
          controller: confirmPasswordController,
          focusNode: confirmPasswordFocusNode,
          onSubmitted: (value) {
            signUpUser();
          },
        ),
        SizedBox(height: 10.0),
        ChangeWidget(
          title: 'Signin',
          onTap: () {
            Navigator.of(context).pop(context);
          },
        ),
      ],
    );
  }
}
