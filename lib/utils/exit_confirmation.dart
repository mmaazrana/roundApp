import 'package:flutter/material.dart';

Future<bool> onWillPop(context) async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          buttonPadding: const EdgeInsets.all(20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          title: Text(
            'Are you sure?',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          content: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: RichText(
                text: const TextSpan(
                    text: 'Do you really want to exit ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                  TextSpan(
                      text: 'ROUND?',
                      style: TextStyle(fontWeight: FontWeight.bold))
                ])),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 237, 94, 106)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // <-- Radius
                )),
                padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
              ),
            ),
          ],
        ),
      )) ??
      false;
}
