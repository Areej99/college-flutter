import 'package:provider/provider.dart';

import '../data.dart';
import 'file:///D:/projects/college/lib/screens/halls_page.dart';
import 'package:college/components/reusable_button.dart';
import 'package:flutter/material.dart';

import 'hall_info.dart';

class MapPage extends StatelessWidget {
  MapPage({this.entryNum, this.hallNum});
  final String hallNum;
  final String entryNum;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    const myHeight = 672;
    const myWidth = 360;

    var usedHight = (height / myHeight);
    var usedWidth = (width / myWidth);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'road',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset('images/مدخل $entryNum ق$hallNum.png'),
            width: 400,
            height: 500,
          ),
          Positioned(
              bottom: 350 * usedHight,
              left: 210 * usedWidth,
              width: 140,
              height: 200,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HallInfo(
                          hall: 'hall 1',
                          isAdmin: false,
                        ),
                      ),
                    );
                  },
                  child: Image.asset('images/hall one.jpeg'))),
          Positioned(
              bottom: 225 * usedHight,
              left: 255 * usedWidth,
              width: 100,
              height: 185,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HallInfo(
                          hall: 'hall 2',
                          isAdmin: false,
                        ),
                      ),
                    );
                  },
                  child: Image.asset('images/hall two.jpeg'))),
          Positioned(
              bottom: 75 * usedHight,
              left: 252 * usedWidth,
              width: 110,
              height: 200,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HallInfo(
                          hall: 'hall 3',
                          isAdmin: false,
                        ),
                      ),
                    );
                  },
                  child: Image.asset('images/hall three.jpeg'))),
          Positioned(
              top: 343 * usedHight,
              left: 215 * usedWidth,
              width: 165,
              height: 190,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HallInfo(
                          hall: 'hall 4',
                          isAdmin: false,
                        ),
                      ),
                    );
                  },
                  child: Image.asset('images/hall four.jpeg'))),
          Positioned(
              bottom: 315 * usedHight,
              width: 140,
              height: 230,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HallInfo(
                          hall: 'hall 5',
                          isAdmin: false,
                        ),
                      ),
                    );
                  },
                  child: Image.asset('images/hall five.jpeg'))),
          Positioned(
              bottom: 232 * usedHight,
              width: 90,
              height: 175,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HallInfo(
                          hall: 'hall 6',
                          isAdmin: false,
                        ),
                      ),
                    );
                  },
                  child: Image.asset('images/hall six.jpeg'))),
          Positioned(
              bottom: 75 * usedHight,
              width: 100,
              height: 190,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HallInfo(
                          hall: 'hall 7',
                          isAdmin: false,
                        ),
                      ),
                    );
                  },
                  child: Image.asset('images/hall seven .jpeg'))),
          Positioned(
            top: 340 * usedHight,
            width: 145,
            height: 190,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HallInfo(
                      hall: 'hall 8',
                      isAdmin: false,
                    ),
                  ),
                );
              },
              child: Image.asset('images/hall eight.jpeg'),
            ),
          ),
        ],
      ),
    );
  }
}
