import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/sub/lookFor.dart';
import 'package:flutter_application/sub/putOut1.dart';
import 'package:get/get.dart';

import 'imageUpload.dart';
import 'kakaoLogin.dart';
import 'login.dart';

class ViewMoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text(
                '더보기',
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
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            ListTile(
              title: Text('로그인/회원가입'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => KakaoLoginApp()));
              },
            ),
            ListTile(
              title: Text('사업소개'),
              onTap: () {},
            ),
            ListTile(
              title: Text('공지사항'),
              onTap: () {},
            ),
            ListTile(
              title: Text('공간구해요'),
              onTap: () {
                Get.to(() => LookForPage());
              },
            ),
            ListTile(
              title: Text('공간 나눠요'),
              onTap: () {
                Get.to(() => putOutPage1());
              },
            ),
            ListTile(
              title: Text('Q&A'),
              onTap: () {},
            ),
            // ElevatedButton(child: Text('고객센터'), onPressed: () async {})
          ],
        ));
  }
}
