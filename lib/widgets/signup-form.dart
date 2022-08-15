import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/auth.dart';
import 'buttons/login-button.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
    required this.tabController,
    required this.color,
  }) : super(key: key);

  final TabController tabController;
  final Color color;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool value = false;
  String? errorMessage = 'No Error';
  final User? user = Auth().currentUser;
  bool isLogin = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future<void> _createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: emailController.text, password: nameController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  // void _register() async {
  //   final User? user = (await _auth.createUserWithEmailAndPassword(
  //     email: widget.emailController.text,
  //     password: widget.nameController.text,
  //   ))
  //       .user;
  //   if (user != null) {
  //     setState(() {
  //       _success = true;
  //       _userEmail = user.email!;
  //     });
  //   } else {
  //     setState(() {
  //       _success = true;
  //     });
  //   }
  // }

  // @override
  // void dispose() {
  //   widget.emailController.dispose();
  //   widget.nameController.dispose();
  //   super.dispose();
  // }

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
                "Name",
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
                autocorrect: false,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                  hintText: 'Enter Name',
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
                controller: nameController,
                autocorrect: false,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                  hintText: 'Enter Email',
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: value,
                onChanged: (bool? val) {
                  setState(() {
                    value = val!;
                  });
                },
              ),
              const Text(
                "I agree to ROUND’s Terms of Use & Privacy Policy",
                style: TextStyle(
                  color: Color(
                    0xff707070,
                  ),
                  fontSize: 12,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          LoginButton(
            text: "Sign Up",
            onPressed: () {
              _createUserWithEmailAndPassword();
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an Account?",
                style: TextStyle(
                    color: Color(0xff5A595A),
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              TextButton(
                onPressed: () => widget.tabController
                    .animateTo((widget.tabController.index + 1) % 2),
                child: Text(
                  "Sign In",
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
