import 'package:flutter/material.dart';

class Maps extends StatelessWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Image.asset(
                              "assets/images/shoe.png",
                              width: 70,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "RND 100",
                            style: TextStyle(color: color, fontSize: 8),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Image.asset("assets/images/shoe_rare.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "RND 170",
                            style: TextStyle(color: color, fontSize: 8),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Image.asset("assets/images/shoe_epic.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "RND 250",
                            style: TextStyle(color: color, fontSize: 8),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child:
                                Image.asset("assets/images/shoe_legendary.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "RND 400",
                            style: TextStyle(color: color, fontSize: 8),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Image.asset(
                              "assets/images/bike_common.png",
                              width: 70,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "RND 100",
                            style: TextStyle(color: color, fontSize: 8),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Image.asset("assets/images/bike.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "RND 170",
                            style: TextStyle(color: color, fontSize: 8),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: Image.asset("assets/images/bike_epic.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "RND 250",
                            style: TextStyle(color: color, fontSize: 8),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child:
                                Image.asset("assets/images/bike_legendary.png"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "RND 400",
                            style: TextStyle(color: color, fontSize: 8),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
