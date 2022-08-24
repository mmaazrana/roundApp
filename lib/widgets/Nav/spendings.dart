import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../spending.dart';

class Spendings extends StatefulWidget {
  const Spendings({Key? key, required this.myFormat}) : super(key: key);
  final NumberFormat myFormat;

  @override
  State<Spendings> createState() => _SpendingsState();
}

class _SpendingsState extends State<Spendings>
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
    _tabController = TabController(length: 4, vsync: this);
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

    return Stack(
      children: [
        [
          Spending(
              color: color,
              totalNumber: 1000,
              userNumber: 125.32,
              myFormat: widget.myFormat),
          Spending(
              color: color,
              totalNumber: 7000,
              userNumber: 2453.24,
              myFormat: widget.myFormat),
          Spending(
              color: color,
              totalNumber: 28000,
              userNumber: 12431.23,
              myFormat: widget.myFormat),
          Spending(
              color: color,
              totalNumber: 400000,
              userNumber: 115467.32,
              myFormat: widget.myFormat),
        ][_tabIndex],
        Container(
          color: Colors.white,
          height: 37,
          padding: EdgeInsets.fromLTRB(
            15,
            5,
            15,
            5,
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                50.0,
              ),
              color: color.withOpacity(0.15),
            ),
            labelColor: color,
            unselectedLabelColor: color,
            tabs: const [
              Tab(
                child: Text(
                  "Daily",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                height: 20,
              ),
              Tab(
                child: Text(
                  "Weekly",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                height: 20,
              ),
              Tab(
                child: Text(
                  "Monthly",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                height: 20,
              ),
              Tab(
                child: Text(
                  "Yearly",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
