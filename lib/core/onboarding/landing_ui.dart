

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        systemNavigationBarColor: Colors.white10, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
      ),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: SvgPicture.asset(
                'assets/images/cx-landing.svg',
                semanticsLabel: 'Landing Page Svg',
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Column(
              children: [
                Text(
                  'Welcome to Crypto Expo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Improve your trading confidence with quality signals',
                    style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 13,
                        color: Color.fromRGBO(0, 0, 0, 0.38823529411764707)
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF223253),
                  minimumSize: Size(double.infinity, 30), // double.infinity is the width and 30 is the height
                ),
                onPressed: () {},
                child: Padding(
                    child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                        )
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
              ),
            ),
          ],
        ),

      ),
    );
  }

}