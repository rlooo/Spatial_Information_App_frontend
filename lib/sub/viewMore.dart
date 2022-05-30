import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/sub/QnA.dart';
import 'package:flutter_application/sub/introduce.dart';
import 'package:flutter_application/sub/lookFor.dart';
import 'package:flutter_application/sub/putOut1.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'imageUpload.dart';
import 'kakaoLogin.dart';
import 'notice.dart';

void logout() async {
  try {
    await UserApi.instance.logout();
    print('로그아웃 성공, SDK에서 토큰 삭제');
  } catch (error) {
    print('로그아웃 실패, SDK에서 토큰 삭제 $error');
  }
}

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
                Get.to(() => KakaoLoginApp());
              },
            ),
            ListTile(
              title: Text('사업소개'),
              onTap: () {
                Get.to(() => IntroducePage());
              },
            ),
            ListTile(
              title: Text('공지사항'),
              onTap: () {
                Get.to(() => NoticePage());
              },
            ),
            ListTile(
              title: Text('공간 구해요'),
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
              onTap: () {
                Get.to(() => QnAPage());
              },
            ),
            ListTile(
              title: Text('로그아웃'),
              onTap: () {
                logout();
                LogoutToast();
              },
            ),
            // ElevatedButton(child: Text('고객센터'), onPressed: () async {})
          ],
        ));
  }

  void LogoutToast() {
    Fluttertoast.showToast(
        msg: "로그아웃되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
