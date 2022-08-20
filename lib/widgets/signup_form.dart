import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roundapp/screens/email_verification.dart';

import '../utils/auth.dart';
import '../utils/loading.dart';
import 'buttons/login_button.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpForm extends StatefulWidget {
  SignUpForm({
    Key? key,
    required this.tabController,
    required this.color,
    required this.isLoading,
  }) : super(key: key);

  final TabController tabController;
  final Color color;
  bool isLoading;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool value = false;
  final User? user = Auth().currentUser;
  bool isLogin = true;
  bool visible = false;
  bool confirmationVisible = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  Future<void> _createUserWithEmailAndPassword() async {
    setState(() {
      widget.isLoading = true;
    });
    try {
      await Auth()
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            name: nameController.text.trim(),
          )
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Code Sent to email'),
                backgroundColor: widget.color,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10),
                elevation: 15,
              )))
          .then(
            (value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const EmailVerification(),
              ),
            ),
          );
    } on FirebaseAuthException catch (e) {
      setState(() {
        widget.isLoading = false;
      });
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
    nameController.dispose();
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
                controller: nameController,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                  hintText: 'Enter Name',
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
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                  hintText: 'Enter Email',
                  errorStyle: TextStyle(fontSize: 12, height: 0.75),
                ),
              ),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
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
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Confirm Password",
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
                controller: passwordConfirmationController,
                obscureText: !confirmationVisible,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please re enter your password';
                  }
                  if (value != passwordController.text) {
                    return "Password Don't match";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                  hintText: 'Re Enter Password',
                  alignLabelWithHint: true,
                  errorStyle: const TextStyle(fontSize: 12, height: 0.75),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      confirmationVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: widget.color,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        confirmationVisible = !confirmationVisible;
                      });
                    },
                  ),
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
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (value) {
                  _createUserWithEmailAndPassword();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                        "Kindly agree to ROUND'S terms and conditions"),
                    backgroundColor: widget.color,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(10),
                    elevation: 15,
                  ));
                }
              } else {}
            },
            child: const Text("Sign Up",
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
