import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application/data/user.dart';
import 'package:flutter_application/src/databaseApp.dart';
import 'package:flutter_application/sub/logout.dart';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  //Firebase 설정
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseURL =
      'https://spartialdatainfrastructure-default-rtdb.firebaseio.com/';

  // //flutter_secure_storage 사용을 위한 초기화 작업
  // static final storage = new FlutterSecureStorage();
  // String userInfo = ""; //user의 정보를 저장하기 위한 변수

  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('user');

    // //비동기로 flutter secure storage 정보를 불러오는 작업
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   _asyncMethod();
    // });
    // }
    // _asyncMethod() async {
    //   // read 함수를 통하여 key 값에 맞는 정보를 불러온다. (이 때 불러오는 결과의 타입은 String 타입이다.)
    //   // (데이터가 없을 때는 null을 반환한다.)
    //   userInfo = (await storage.read(key: "login"))!;
    //
    //   // user의 정보가 있다면 바로 로그아웃 페이지로 넘어간다.
    //   if(userInfo != null){
    //     Map<String,dynamic> userInfo_json = jsonDecode(userInfo);
    //     Navigator.pushReplacement(
    //         context,
    //         CupertinoPageRoute(
    //             builder: (context) => LogOutPage(
    //               login_id: userInfo_json['login_id'],
    //               email: userInfo_json['email'],
    //               access_token: userInfo_json['access_token'],
    //               refresh_token: userInfo_json['refresh_token'],
    //               createTime: userInfo_json['createTime'],
    //             )));
    //   }
  }

  // 로그인
  Future<UserCredential> loginWithKakao() async {
    final clientState = Uuid().v4();
    final authUri = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'response_type': 'code',
      'client_id': '7f44810be24159eb8b2748926096d3d8',
      'response_mode': 'form_post',
      'redirect_uri': 'http://10.0.2.2:8000/user/signin/kakao/token',
      // 'scope': 'profile_nickname', 다 받을거임
      'state': clientState,
    });
    final authResponse = await FlutterWebAuth.authenticate(
        url: authUri.toString(), callbackUrlScheme: "webauthcallback");
    final code = Uri.parse(authResponse).queryParameters['code'];

    final tokenResult = await http.get(
        Uri.parse('http://10.0.2.2:8000/user/signin/kakao/token?code=$code'));
    print(tokenResult);
    final uid = json.decode(tokenResult.body)['uid'];
    final email = json.decode(tokenResult.body)['email'];
    final nickname = json.decode(tokenResult.body)['nickname'];

    print(uid);
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/user/signin/kakao/customtoken/?uid=$uid&email=$email&nickname=$nickname'));

    final customToken = json.decode(response.body)['custom_token'];
    print(customToken);
    return await FirebaseAuth.instance.signInWithCustomToken(customToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextButton(
            //   child: Text("Google Login"),
            //   onPressed: signInWithGoogle,
            // ),
            SizedBox(
              //width: MediaQuery.of(context).size.width,
              child: CupertinoButton(
                onPressed: loginWithKakao,
                color: Colors.yellow,
                child: Text(
                  '카카오톡으로 시작하기',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
