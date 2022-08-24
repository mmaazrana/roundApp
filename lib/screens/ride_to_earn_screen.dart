import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'move_to_earn_screen.dart';

class RideToEarnScreen extends StatelessWidget {
  const RideToEarnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              height: 500,
                              width: 500,
                            )),
                        Positioned(
                          left: 15,
                          top: 30,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 175,
                          ),
                        ),
                        Positioned(
                          top: 35,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  left: 0,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: Colors.white,
                                      size: 25.0,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Ride to Earn",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: ElevatedButton(
                          onPressed: null,
                          child: const Text(
                            "TRAINING MODE",
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
                                if (states.contains(MaterialState.disabled)) {
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
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: ElevatedButton(
                          onPressed: null,
                          child: const Text(
                            "MARATHON MODE",
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
                                if (states.contains(MaterialState.disabled)) {
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
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: ElevatedButton(
                          onPressed: null,
                          child: const Text(
                            "DISCOVERY MODE",
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
                                if (states.contains(MaterialState.disabled)) {
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
                      ),
                    ],
                  ),
                  Container(
                    transform: Matrix4.translationValues(0, 10, 0),
                    child: SvgPicture.asset(
                      'assets/svg/ride.svg',
                      width: MediaQuery.of(context).size.width,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
