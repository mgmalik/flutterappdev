import 'package:flutter/material.dart';
import 'package:flutter_lec5_signin_signup_app/model/state_provider.dart';
import 'package:flutter_lec5_signin_signup_app/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextfieldWidget(
          hintText: 'Name',
          obscureText: false,
          prefixIconData: Icons.verified_user,
          color: Colors.indigo,
          suffixIconData: null,
          isValid: context.watch<StateProvider>().isValid,
          onChanged: (value) {
            // verify email...
            if (value.toString().length > 3) {
              context.read<StateProvider>().isValid = true;
            } else {
              context.read<StateProvider>().isValid = false;
            }
          },
          controller: nameController,
        ),
        SizedBox(height: 10.0),
        TextfieldWidget(
          hintText: 'Email',
          obscureText: false,
          prefixIconData: Icons.mail_outline,
          color: Colors.indigo,
          suffixIconData: null,
          isValid: context.watch<StateProvider>().isValidEmail,
          onChanged: (value) {
            // verify email...
            context.read<StateProvider>().verifyEmail(value);
          },
          controller: emailController,
        ),
        SizedBox(height: 10.0),
        TextfieldWidget(
          hintText: 'Password',
          obscureText: context.watch<StateProvider>().isVisible ? false : true,
          prefixIconData: Icons.lock_outline,
          color: Colors.indigo,
          isValid: context.watch<StateProvider>().isValidPassword,
          suffixIconData: context.watch<StateProvider>().isVisible
              ? Icons.visibility
              : Icons.visibility_off,
          onChanged: (value) {
            // may apply the rules for password selection
            context.read<StateProvider>().verifyPassword(value);
          },
          controller: passwordController,
        ),
        SizedBox(height: 10.0),
        TextfieldWidget(
          hintText: 'Confirm Password',
          obscureText: context.watch<StateProvider>().isVisible ? false : true,
          prefixIconData: Icons.lock_outline,
          color: Colors.indigo,
          isValid: context.watch<StateProvider>().isValidConfirmPassword,
          suffixIconData: context.watch<StateProvider>().isVisible
              ? Icons.visibility
              : Icons.visibility_off,
          onChanged: (value) {
            // may apply the rules for password selection
            context.read<StateProvider>().verifyConfirmPassword(
              value,
              passwordController.text,
            );
          },
          controller: confirmPasswordController,
        ),
      ],
    );
  }
}
