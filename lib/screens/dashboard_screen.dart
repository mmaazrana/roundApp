import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:roundapp/screens/running_screen.dart';
import 'package:roundapp/widgets/Nav/maps.dart';
import 'package:roundapp/widgets/Nav/nft.dart';
import 'package:roundapp/widgets/Nav/spendings.dart';
import 'package:roundapp/widgets/Nav/wallet.dart';

import '../utils/auth.dart';
import '../utils/exit_confirmation.dart';
import '../utils/loading.dart';
import '../widgets/Nav/dashboard.dart';

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
    List<Widget> _widgetOptions = <Widget>[
      DashBoard(
        color: color,
        totalNumber: totalNumber,
        userNumber: userNumber,
        myFormat: myFormat,
      ),
      Maps(),
      Spendings(
        myFormat: myFormat,
      ),
      Wallet(
          color: color, totalNumber: 750, userNumber: 500, myFormat: myFormat),
      NFT(),
    ];
    List<Widget> _titleOptions = <Widget>[
      Text(
        "Dashboard",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      Text(
        "Maps",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      Text(
        "Spendings",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      Text(
        "Wallet",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      Text(
        "NFTS",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ];

    getWaitlist();

    return isLoading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: _titleOptions.elementAt(_selectedIndex),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            body: _widgetOptions.elementAt(_selectedIndex),
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
          );
  }
}
