import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roundapp/auth/auth.dart';
import 'package:roundapp/screens/splash-screen.dart';

import 'buttons/login-button.dart';

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
  String? errorMessage = 'No Error';
  final User? user = Auth().currentUser;
  bool isLogin = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Signed In Successfull'),
      ));
    } on FirebaseAuthException catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message!),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

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
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                  hintText: 'Enter Email',
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
                obscureText: true,
                autocorrect: false,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                  hintText: 'Enter Password',
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
          // ElevatedButton(
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       content: Text('Yay! A SnackBar!'),
          //     ));
          //   },
          //   child: Text("Toast!"),
          // ),
          TextButton(
            onPressed: () {
              _signInWithEmailAndPassword();
            },
            child: Text("Sign In",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(1)),
              backgroundColor: MaterialStateProperty.all(color),
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
