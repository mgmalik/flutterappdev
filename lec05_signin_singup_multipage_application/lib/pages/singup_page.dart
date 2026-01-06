import 'package:flutter/material.dart';
import 'package:lec05_signin_singup_multipage_application/models/home_model.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/animated_top_widget.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/button_widget.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/signup_widget.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late FocusNode nameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedTopWidget(
            title: 'Signup',
            size: size,
            keyboardOpen: keyboardOpen,
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SignupWidget(
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  nameFocusNode: nameFocusNode,
                  emailFocusNode: emailFocusNode,
                  passwordFocusNode: passwordFocusNode,
                  confirmPasswordFocusNode: confirmPasswordFocusNode,
                  signUpUser: _SignUpUser,
                ),
                SizedBox(height: 20.0),
                ButtonWidget(
                  title: 'Signup',
                  onPressed: () {
                    _SignUpUser();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _SignUpUser() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    if (context.read<HomeModel>().isValid &&
        context.read<HomeModel>().isValidEmail &&
        context.read<HomeModel>().isValidPassword &&
        context.read<HomeModel>().isValidConfirmPassword) {
      if (await context.read<HomeModel>().addUser(name, email, password)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Wawoo! $name!!! You have successfully Signed UP'),
            action: SnackBarAction(
              label: 'Go to Login',
              onPressed: () {
                Navigator.of(context).pop(context);
              },
            ),
            duration: Duration(seconds: 2),
            width: 300.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sorry! You failed to Signed UP'),
            duration: Duration(seconds: 2),
            width: 300.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please provide all information to Signup!!!'),
          duration: Duration(seconds: 2),
          width: 300.0,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      );
    }
  }
}
