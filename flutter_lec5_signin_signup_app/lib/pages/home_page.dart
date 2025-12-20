import 'package:flutter/material.dart';
import 'package:flutter_lec5_signin_signup_app/model/state_provider.dart';
import 'package:flutter_lec5_signin_signup_app/model/user_model.dart';
import 'package:flutter_lec5_signin_signup_app/widgets/button_widget.dart';
import 'package:flutter_lec5_signin_signup_app/widgets/change_focus_widget.dart';
import 'package:flutter_lec5_signin_signup_app/widgets/signin_widget.dart';
import 'package:flutter_lec5_signin_signup_app/widgets/signup_widget.dart';
import 'package:flutter_lec5_signin_signup_app/widgets/wave_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: Stack(
        children: [
          Container(height: size.height - 200, color: Colors.indigo),
          AnimatedPositioned(
            duration: Duration(seconds: 5),
            curve: Curves.easeOutQuad,
            top: isKeyboardOpen ? -size.height / 3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height / 3,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: isKeyboardOpen ? 15.0 : 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.watch<StateProvider>().isSignup ? 'Signup' : 'Signin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                (context.watch<StateProvider>().isSignup
                    ? SignupWidget(
                        nameController: nameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                      )
                    : SigninWidget(
                        emailController: emailController,
                        passwordController: passwordController,
                      )),
                SizedBox(height: 10.0),
                ChangeWidget(onTap: changeFocus),
                SizedBox(height: 20.0),
                ButtonWidget(
                  title: context.watch<StateProvider>().isSignup
                      ? 'Signup'
                      : 'Signin',
                  onTab: signinOrSignup,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void changeFocus() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    context.read<StateProvider>().isSignup = !context
        .read<StateProvider>()
        .isSignup;
  }

  void signinOrSignup() {
    if (context.read<StateProvider>().isSignup) {
      // get data from the user and add it if not already exisits
      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      if (context.read<StateProvider>().isValid &&
          context.read<StateProvider>().isValidEmail &&
          context.read<StateProvider>().isValidPassword &&
          context.read<StateProvider>().isValidConfirmPassword) {
        if (context.read<StateProvider>().addUser(name, email, password)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Wawoo! $name!!! You have successfully Signed UP'),
              action: SnackBarAction(
                label: 'Go to Login',
                onPressed: () {
                  changeFocus();
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
    } else {
      // get email and password to verify the user
      String email = emailController.text;
      String password = passwordController.text;
      UserModel? user = context.read<StateProvider>().getValidUser(
        email,
        password,
      );
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Wawoo! ${user.name}!!! You have successfully logged in',
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
            content: Text('Sorry! You failed to logged in'),
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
}
