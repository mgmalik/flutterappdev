import 'package:flutter/material.dart';
import 'package:lec05_signin_singup_multipage_application/models/home_model.dart';
import 'package:lec05_signin_singup_multipage_application/models/user_model.dart';
import 'package:lec05_signin_singup_multipage_application/pages/home_page.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/animated_top_widget.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/button_widget.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/signin_widget.dart';
import 'package:provider/provider.dart';

class SinginPage extends StatefulWidget {
  const SinginPage({super.key});

  @override
  State<SinginPage> createState() => _SinginPageState();
}

class _SinginPageState extends State<SinginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
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
            title: 'Singin',
            size: size,
            keyboardOpen: keyboardOpen,
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SigninWidget(
                  emailController: emailController,
                  passwordController: passwordController,
                  emailFocusNode: emailFocusNode,
                  passwordFocusNode: passwordFocusNode,
                  signInUser: _signInUser,
                ),
                SizedBox(height: 20.0),
                ButtonWidget(
                  title: 'Signin',
                  onPressed: () {
                    _signInUser();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _signInUser() {
    // get email and password to verify the user
    String email = emailController.text;
    String password = passwordController.text;
    final UserModel? user = context.read<HomeModel>().getValidUser(
      email,
      password,
    );
    if (user != null) {
      emailController.clear();
      passwordController.clear();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //       'Wawoo! ${user.name}!!! You have successfully logged in',
      //     ),
      //     duration: Duration(seconds: 2),
      //     width: 300.0,
      //     padding: EdgeInsets.symmetric(horizontal: 10.0),
      //     behavior: SnackBarBehavior.floating,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12.0),
      //     ),
      //   ),
      // );
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => HomePage(userModel: user),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sorry! You failed to logged in. Please try again!'),
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
