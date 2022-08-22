import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roundapp/screens/dashboard_screen.dart';
import 'package:roundapp/screens/move_to_earn_screen.dart';
import 'package:roundapp/screens/ride_to_earn_screen.dart';

import '../utils/exit_confirmation.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      return onWillPop(context);
    }, child: Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned(
                            left: -160,
                            top: -240,
                            child: SvgPicture.asset(
                              "assets/svg/gradient.svg",
                              height: 480,
                              width: 480,
                            )),
                        Positioned(
                          left: 15,
                          top: 60,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 175,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => MoveToEarnScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "MOVE TO EARN",
                                style: TextStyle(
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
                            ),
                            Positioned(
                              left: 10,
                              child: Image.asset("assets/images/shoe.png"),
                            ),
                            const Positioned(
                              right: 15,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RideToEarnScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "RIDE TO EARN",
                                style: TextStyle(
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
                            ),
                            Positioned(
                              left: 15,
                              child: Image.asset("assets/images/bike.png"),
                            ),
                            const Positioned(
                              right: 15,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, 10, 0),
                    child: SvgPicture.asset(
                      'assets/svg/main.svg',
                      width: MediaQuery.of(context).size.width,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
