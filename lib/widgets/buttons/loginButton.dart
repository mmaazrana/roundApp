import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;

  const LoginButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Container(
      margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
      child: TextButton(
        onPressed: () => {},
        child: Text(text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            )),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(1)),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100), // <-- Radius
          )),
          padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
        ),
      ),
    );
  }
}
