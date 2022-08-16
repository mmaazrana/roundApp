import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roundapp/auth/auth.dart';
import 'package:roundapp/screens/dashboard_screen.dart';
import 'package:roundapp/screens/splash_screen.dart';

import 'buttons/login_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.tabController,
    required this.color,
  }) : super(key: key);

  final TabController tabController;
  final Color color;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final User? user = Auth().currentUser;
  bool isLogin = true;
  bool visible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ScaffoldMessengerState snackbar;

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await Auth()
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Signed In Successfull'),
                backgroundColor: widget.color,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10),
                elevation: 15,
              )))
          .then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const DashBoardScreen())));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
        backgroundColor: widget.color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        elevation: 15,
      ));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Email",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff555555),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                  alignLabelWithHint: true,
                  hintText: 'Enter Email',
                  errorStyle: TextStyle(fontSize: 12, height: 0.75),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff555555),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: !visible,
                autocorrect: false,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length <= 5) {
                    return 'Password must be longer than 6 characters';
                  }
                  if (value.length > 20) {
                    return 'Password must not be longer than 20 characters';
                  }
                  if (!(RegExp(r'(?=.*[A-Z])\w+').hasMatch(value))) {
                    return 'Password must contain one uppercase letter';
                  }
                  if (!(RegExp(r'(?=.*[a-z])\w+').hasMatch(value))) {
                    return 'Password must contain one lowercase letter';
                  }
                  if (!(RegExp(r'(?=.*?[0-9])').hasMatch(value))) {
                    return 'Password must contain one numeric character';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  hintText: 'Enter Password',
                  alignLabelWithHint: true,
                  errorStyle: const TextStyle(fontSize: 12, height: 0.75),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      visible ? Icons.visibility : Icons.visibility_off,
                      color: widget.color,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        visible = !visible;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            child: const Text(
              "Forgot Password?",
              style: TextStyle(
                color: Color(0xff707070),
                fontSize: 12,
              ),
            ),
            onPressed: () => {},
          ),
          const SizedBox(
            height: 40,
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _signInWithEmailAndPassword();
              } else {}
            },
            child: const Text("Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(1)),
              backgroundColor: MaterialStateProperty.all(widget.color),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100), // <-- Radius
              )),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an Account?",
                style: TextStyle(
                    color: Color(0xff5A595A),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              TextButton(
                onPressed: () => widget.tabController
                    .animateTo((widget.tabController.index + 1) % 2),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: widget.color,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
