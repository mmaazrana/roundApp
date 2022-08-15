import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roundapp/screens/loginScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Stack(
      children: [
        SvgPicture.asset(
          'assets/svg/splash.svg',
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(95, 0, 95, 0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/logoBackground.svg',
                            color: Colors.white38,
                            width: 210,
                            height: MediaQuery.of(context).size.height,
                            fit: BoxFit.scaleDown,
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            alignment: Alignment.center,
                            width: 165,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.05,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(41, 0, 41, 0),
                        child: TextButton(
                          onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginScreen()))
                          },
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                                color: color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size.fromHeight(1)),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(100), // <-- Radius
                              )),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.all(17),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
