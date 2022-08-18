import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roundapp/screens/choice_screen.dart';
import 'package:roundapp/screens/dashboard_screen.dart';
import 'package:roundapp/screens/login_screen.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified = false;
  Timer? timer;
  static const _timerDuration = 30;
  final StreamController _timerStream = new StreamController<int>();
  int? timerCounter;
  Timer? _resendCodeTimer;

  @override
  void initState() {
    super.initState();
    activeCounter();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (timer) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    _timerStream.close();
    _resendCodeTimer!.cancel();
    timer?.cancel();
    super.dispose();
  }

  activeCounter() {
    _resendCodeTimer =
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_timerDuration - timer.tick > 0) {
        _timerStream.sink.add(_timerDuration - timer.tick);
      } else {
        _timerStream.sink.add(0);
        _resendCodeTimer!.cancel();
      }
    });
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
        elevation: 15,
      ));
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const ChoiceScreen()
      : Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.25,
                        10,
                        MediaQuery.of(context).size.width * 0.25,
                        10,
                      ),
                      child: Image.asset('assets/images/logo.png',
                          alignment: Alignment.center, fit: BoxFit.scaleDown),
                    ),
                    Positioned(
                      top: -75,
                      left: -75,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(
                                0xffDA01C9,
                              ),
                              width: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Welcome ",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: FirebaseAuth
                                  .instance.currentUser!.displayName
                                  .toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text: ", A verification email has been sent to ",
                            ),
                            TextSpan(
                              text: FirebaseAuth.instance.currentUser!.email
                                      .toString() +
                                  "\n",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      StreamBuilder(
                          stream: _timerStream.stream,
                          builder: (context, snapshot) {
                            return ElevatedButton(
                              onPressed: snapshot.data == 0
                                  ? () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                          "Email Sent Succesfully",
                                        ),
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.all(10),
                                        elevation: 15,
                                      ));
                                      _timerStream.sink.add(30);
                                      activeCounter();
                                      sendVerificationEmail();
                                    }
                                  : null,
                              child: snapshot.data == 0
                                  ? const Text(
                                      "Resend Email",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : Text(
                                      "Resend Email in ${snapshot.hasData ? snapshot.data.toString() : 30}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size.fromHeight(1)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.25);
                                    }
                                    return Theme.of(context)
                                        .primaryColor; // Use the component's default.
                                  },
                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10), // <-- Radius
                                )),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(15)),
                              ),
                            );
                          }),
                      TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value) =>
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen())));
                          },
                          child: const Text("Cancel")),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Don't forget to check your spam folder",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  width: 150,
                  transform: Matrix4.translationValues(
                      MediaQuery.of(context).size.width * 0.5, 75, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color(
                          0xffDA01C9,
                        ),
                        width: 15),
                  ),
                ),
              ],
            ),
          ),
        );
}
