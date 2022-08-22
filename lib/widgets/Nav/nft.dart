import 'package:flutter/material.dart';

import '../shoe_card.dart';

class NFT extends StatelessWidget {
  const NFT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    var image = "assets/images/shoe.png";
    var name = "Common";
    var rnd = "RND: 100";
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Card(
            shadowColor: Colors.black.withOpacity(0),
            elevation: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shoes",
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    child: Row(
                      children: [
                        ShoeCard(
                            image: "assets/images/shoe.png",
                            name: "Common",
                            color: color,
                            rnd: 100),
                        ShoeCard(
                            image: "assets/images/shoe_rare.png",
                            name: "Rare",
                            color: color,
                            rnd: 170),
                        ShoeCard(
                            image: "assets/images/shoe_epic.png",
                            name: "Epic",
                            color: color,
                            rnd: 250),
                        ShoeCard(
                            image: "assets/images/shoe_legendary.png",
                            name: "Legendary",
                            color: color,
                            rnd: 400),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Card(
            shadowColor: Colors.black.withOpacity(0),
            elevation: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bicycles",
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    child: Row(
                      children: [
                        ShoeCard(
                            image: "assets/images/bike_common.png",
                            name: "Common",
                            color: color,
                            rnd: 100),
                        ShoeCard(
                            image: "assets/images/bike.png",
                            name: "Rare",
                            color: color,
                            rnd: 170),
                        ShoeCard(
                            image: "assets/images/bike_epic.png",
                            name: "Epic",
                            color: color,
                            rnd: 250),
                        ShoeCard(
                            image: "assets/images/bike_legendary.png",
                            name: "Legendary",
                            color: color,
                            rnd: 400),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
