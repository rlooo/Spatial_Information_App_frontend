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
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              '터새로이와 함께하는 공간나눔사업',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(width: 4.0),
            const Icon(
              CupertinoIcons.chevron_down,
              size: 15.0,
            )
          ],
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(thickness: 0.5, height: 0.5, color: Colors.grey),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            child: Text(
              '어떤 공간을 찾고 계신가요?',
              style: GoogleFonts.nanumGothic(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 150.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
            children: <Widget>[
              ElevatedButton(
                  child: Text(
                    '공간구해요',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: Size(150, 100),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapPage()));
                  }),
              SizedBox(
                width: 15.0,
              ),
              ElevatedButton(
                  child: Text(
                    '공간나눠요',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: Size(150, 100),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => putOutPage1()));
                  }),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
            children: <Widget>[
              ElevatedButton(
                  child: Text(
                    '공간나눔사업이란?',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: Size(300, 10),
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
        ],
      ),
    );
  }
}
