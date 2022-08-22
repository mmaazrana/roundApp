import 'package:flutter/material.dart';

class ShoeCard extends StatelessWidget {
  const ShoeCard({
    Key? key,
    required this.image,
    required this.name,
    required this.color,
    required this.rnd,
  }) : super(key: key);

  final String image;
  final String name;
  final Color color;
  final int rnd;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
                child: Container(
                    height: 70,
                    width: 70,
                    padding: EdgeInsets.all(5),
                    child: Image.asset(image))),
            Container(
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
                borderRadius:
                    const BorderRadius.all(Radius.elliptical(100, 100)),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              name,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 8,
              ),
            ),
            Text(
              "RND: " + rnd.toString(),
              style: TextStyle(
                fontSize: 8,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
