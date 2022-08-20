import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Container(
      color: Colors.black12,
      child: Center(
        child: SpinKitChasingDots(
          color: color,
          size: 50.0,
        ),
      ),
    );
  }
}
