import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/sub/putOut1.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';
import 'introduce.dart';
import 'mapPage.dart';

class HomeApp extends StatelessWidget {
  var switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff662D91),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/공간나눔사업 로고.png',
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                '터새로이와 함께하는',
                style: GoogleFonts.nanumGothic(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              child: Text(
                '공간나눔 사업',
                style: GoogleFonts.nanumGothic(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
              children: <Widget>[
                ElevatedButton(
                    child: Text(
                      '공간나눔사업이란?',
                      style: TextStyle(color: Color(0xff662D91)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        primary: Colors.white,
                        minimumSize: Size(230, 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IntroducePage()));
                    }),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
              children: <Widget>[
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => putOutPage1()));
                  },
                  icon: Image.asset("images/공간나눠요_둥근네모.png",
                      width: 100, height: 100),
                  iconSize: 120,
                ),
                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapPage()));
                  },
                  icon: Image.asset("images/공간구해요_둥근네모.png",
                      width: 100, height: 100),
                  iconSize: 120,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
