import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

import '../utils/auth.dart';
import '../utils/exit_confirmation.dart';
import '../utils/loading.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
  double userNumber = 1;
  double totalNumber = 1;
  int _selectedIndex = 0;
  bool isLoading = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getWaitlist() {
    FirebaseFirestore.instance
        .collection('Waitlist')
        .doc('waitlist')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data()! as Map<String, dynamic>;
        setState(() {
          totalNumber = double.parse(data['length'].toString()) + 176;
        });
      }
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(Auth().currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data()! as Map<String, dynamic>;
        setState(() {
          userNumber = double.parse(data['number'].toString()) + 176;
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    getWaitlist();

    return WillPopScope(
      onWillPop: () {
        return onWillPop(context);
      },
      child: isLoading
          ? const Loading()
          : Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
              ),
              body: Center(
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(
                                  0, -3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Hello Again, ",
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 16),
                                children: [
                                  TextSpan(
                                      text:
                                          "${Auth().currentUser!.displayName}",
                                      style: TextStyle(
                                        color: color,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "We are thankful for your patience and will be reaching out to you soon",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                PieChart(
                                  dataMap: {
                                    "number": totalNumber - userNumber,
                                  },
                                  animationDuration:
                                      const Duration(milliseconds: 1500),
                                  chartRadius:
                                      MediaQuery.of(context).size.width / 1.6,
                                  colorList: [color],
                                  baseChartColor: const Color(0xffF5F5F5),
                                  initialAngleInDegree: -90,
                                  chartType: ChartType.ring,
                                  ringStrokeWidth: 25,
                                  legendOptions: const LegendOptions(
                                    showLegends: false,
                                  ),
                                  totalValue: totalNumber,
                                  chartValuesOptions: const ChartValuesOptions(
                                    showChartValues: false,
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "You're",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "#${myFormat.format(userNumber)}",
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: color,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "out of ${myFormat.format(totalNumber)}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "On the waitlist",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    "In the mean time, Check out some of our ",
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "upcoming features ",
                                      style: TextStyle(
                                          color: color,
                                          fontWeight: FontWeight.bold)),
                                  const TextSpan(text: "below")
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Card(
                        elevation: 0,
                        margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        color: Colors.white,
                        child: IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 16,
                                  offset: const Offset(
                                      0, -3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    width: 70,
                                    padding: const EdgeInsets.all(5),
                                    child:
                                        Image.asset("assets/images/shoe.png"),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 16,
                                          offset: const Offset(0,
                                              -3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Earning Steps",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "132",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: color,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 5, 12, 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(30)),
                                                ),
                                                child: const Text(
                                                  "5 min",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: const [
                                              Text(
                                                "Total:132",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 16,
                                          offset: const Offset(0,
                                              -3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "360",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "R&D",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        color: Colors.white,
                        child: IntrinsicHeight(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 16,
                                  offset: const Offset(
                                      0, -3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    width: 70,
                                    padding: const EdgeInsets.all(5),
                                    child:
                                        Image.asset("assets/images/bike.png"),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 16,
                                          offset: const Offset(0,
                                              -3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Earning Rides",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "132",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: color,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 5, 12, 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(30)),
                                                ),
                                                child: const Text(
                                                  "5 min",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: const [
                                              Text(
                                                "Total:132",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 16,
                                          offset: const Offset(0,
                                              -3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "360",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "R&D",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                margin: const EdgeInsets.all(10),
                                shadowColor: Colors.black.withOpacity(0.5),
                                color: Colors.white,
                                elevation: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/gift.png"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 5),
                                        child: Text(
                                          "MysteryBox",
                                          style: TextStyle(
                                              color: color, fontSize: 12),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: color, width: 1)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Card(
                                margin: const EdgeInsets.all(10),
                                shadowColor: Colors.black.withOpacity(0.5),
                                color: Colors.white,
                                elevation: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/gift.png"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 5),
                                        child: Text(
                                          "MysteryBox",
                                          style: TextStyle(
                                              color: color, fontSize: 12),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                                color: color, width: 1)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "Start Running",
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "Start Riding",
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
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/svg/dashboard.svg',
                      color: _selectedIndex == 0 ? color : Colors.black54,
                    ),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/svg/map.svg',
                      color: _selectedIndex == 1 ? color : Colors.black54,
                    ),
                    label: 'Maps',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/svg/spending.svg',
                      color: _selectedIndex == 2 ? color : Colors.black54,
                    ),
                    label: 'Spendings',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/svg/wallet.svg',
                      color: _selectedIndex == 3 ? color : Colors.black54,
                    ),
                    label: 'Wallet',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/svg/nft.svg',
                      color: _selectedIndex == 4 ? color : Colors.black54,
                    ),
                    label: 'NFTs',
                  ),
                ],
                type: BottomNavigationBarType.shifting,
                currentIndex: _selectedIndex,
                selectedItemColor: color,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.black54,
                unselectedFontSize: 8,
                selectedFontSize: 8,
                iconSize: 25,
                onTap: _onItemTapped,
                elevation: 15,
              ),
            ),
    );
  }
}
