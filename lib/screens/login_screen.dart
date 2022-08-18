import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roundapp/utils/exit_confirmation.dart';

import '../widgets/login_form.dart';
import '../widgets/signup_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return WillPopScope(
      onWillPop: () {
        return onWillPop(context);
      },
      child: Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.75,
                        maxHeight: double.infinity,
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
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
                          padding: const EdgeInsets.fromLTRB(25, 32, 25, 10),
                          child: Column(
                            children: [
                              Container(
                                height: 37,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: color,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(50.0)),
                                child: TabBar(
                                  controller: _tabController,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      50.0,
                                    ),
                                    color: color,
                                  ),
                                  labelColor: Colors.white,
                                  unselectedLabelColor: color,
                                  tabs: const [
                                    Tab(
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      height: 20,
                                    ),
                                    Tab(
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              [
                                LoginForm(
                                    tabController: _tabController,
                                    color: color),
                                SignUpForm(
                                    tabController: _tabController,
                                    color: color),
                              ][_tabIndex],
                            ],
                          )),
                    ),
                    Positioned(
                      bottom: -75,
                      right: -75,
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
              ],
            ),
          );
        }),
      ),
    );
  }
}
