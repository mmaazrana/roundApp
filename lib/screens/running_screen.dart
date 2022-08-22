import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pie_chart/pie_chart.dart';

import '../utils/auth.dart';
import '../widgets/arc.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class RunningScreen extends StatefulWidget {
  RunningScreen({Key? key}) : super(key: key);

  @override
  State<RunningScreen> createState() => _RunningScreenState();
}

class _RunningScreenState extends State<RunningScreen> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Unavailable';
    });
  }

  void initPlatformState() async {
    while (await Permission.activityRecognition.status.isDenied) {
      await Permission.activityRecognition.request();
    }
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    double totalSteps = 10000;
    double currentSteps = double.tryParse(_steps) ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Steps",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  text: "Hello Again, ",
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                  children: [
                    TextSpan(
                        text: "${Auth().currentUser!.displayName}",
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    dataMap: {
                      "number": currentSteps,
                    },
                    animationDuration: const Duration(milliseconds: 1500),
                    chartRadius: MediaQuery.of(context).size.width * 0.75,
                    colorList: const [
                      Color(0xffDA01C9),
                    ],
                    baseChartColor: Color(0xffA14DD3),
                    degreeOptions:
                        DegreeOptions(initialAngle: 150, totalDegrees: 240),
                    legendOptions: const LegendOptions(
                      showLegends: false,
                    ),
                    totalValue: totalSteps,
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValues: false,
                    ),
                  ),
                  PieChart(
                    dataMap: {
                      "number": 1,
                    },
                    animationDuration: const Duration(milliseconds: 1500),
                    chartRadius: MediaQuery.of(context).size.width * 0.625,
                    colorList: [
                      const Color(0xff7801C1).withOpacity(0.63),
                    ],
                    baseChartColor: color.withOpacity(0),
                    degreeOptions:
                        DegreeOptions(initialAngle: 150, totalDegrees: 240),
                    legendOptions: const LegendOptions(
                      showLegends: false,
                    ),
                    totalValue: 1,
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValues: false,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        Jiffy(DateTime.now()).format("do MMMM"),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _steps,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Current status:',
                style: TextStyle(
                    fontSize: 18, color: color, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Icon(
                _status == 'walking'
                    ? Icons.directions_walk
                    : _status == 'stopped'
                        ? Icons.accessibility_new
                        : Icons.error,
                size: 50,
              ),
              SizedBox(
                height: 2,
              ),
              Center(
                child: Text(
                  _status,
                  style: _status == 'walking' || _status == 'stopped'
                      ? TextStyle(fontSize: 12, color: Colors.black38)
                      : TextStyle(fontSize: 12, color: Colors.red),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
