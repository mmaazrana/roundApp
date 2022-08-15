import 'package:flutter/material.dart';
import 'package:roundapp/widgets/buttons/loginButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
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
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  autocorrect: false,
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
              height: 25,
            ),
            const LoginButton(
              text: "Sign In",
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: TextStyle(
                      color: Color(0xff5A595A),
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Text(
                    "Signup",
                    style: TextStyle(
                        color: color,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
