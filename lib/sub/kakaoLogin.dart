import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data/user.dart';
import 'home.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;

class KakaoLoginApp extends StatefulWidget {
  // final Future<Database>? db;
  // WishApp({this.db});

  @override
  _KakaoLoginApp createState() => _KakaoLoginApp();
}

class _KakaoLoginApp extends State<KakaoLoginApp> {
  late UserInfo userinfo;

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();

      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
          '\n이메일: ${user.kakaoAccount?.email}');

      userinfo.uid = user.id;

      if (user.kakaoAccount?.email != null) {
        userinfo.email = user.kakaoAccount?.email;
      }

      if (user.kakaoAccount?.profile?.nickname != null) {
        userinfo.nickname = user.kakaoAccount?.profile?.nickname;
      }
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  void logout() async {
    try {
      await UserApi.instance.logout();
      print('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }
  }

  void unlink() async {
    try {
      await UserApi.instance.unlink();
      print('연결 끊기 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('연결 끊기 실패 $error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text(
                '로그인',
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
        body: Container(
            color: Colors.white,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      "카카오톡으로 시작하기",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.yellow,
                    onPressed: () async {
                      if (await AuthApi.instance.hasToken()) {
                        try {
                          AccessTokenInfo tokenInfo =
                              await UserApi.instance.accessTokenInfo();
                          print(
                              '토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
                        } catch (error) {
                          if (error is KakaoException &&
                              error.isInvalidTokenError()) {
                            print('토큰 만료 $error');
                          } else {
                            print('토큰 정보 조회 실패 $error');
                          }
                          try {
                            //카카오 계정으로 로그인
                            OAuthToken token =
                                await UserApi.instance.loginWithKakaoAccount();
                            print('로그인 성공 ${token.accessToken}');
                            _get_user_info();
                          } catch (error) {
                            print('로그인 실패 $error');
                          }
                        }
                      } else {
                        // 카카오톡 설치 여부 확인
                        // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
                        if (await isKakaoTalkInstalled()) {
                          try {
                            await UserApi.instance.loginWithKakaoTalk();
                            print('카카오톡으로 로그인 성공');
                            Get.back();
                            _get_user_info();
                          } catch (error) {
                            print('카카오톡으로 로그인 실패 $error');

                            // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                            // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                            if (error is PlatformException &&
                                error.code == 'CANCELED') {
                              return;
                            }
                            // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                            try {
                              await UserApi.instance.loginWithKakaoAccount();
                              print('카카오계정으로 로그인 성공');
                              _get_user_info();
                              Get.back();
                            } catch (error) {
                              print('카카오계정으로 로그인 실패 $error');
                            }
                          }
                        } else {
                          try {
                            await UserApi.instance.loginWithKakaoAccount();
                            print('카카오계정으로 로그인 성공');
                            _get_user_info();
                            Get.back();
                          } catch (error) {
                            print('카카오계정으로 로그인 실패 $error');
                          }
                        }
                      }
                    },
                  ),
                ]))));
  }

  Future<void> saveUser() async {
    User user = await UserApi.instance.me();

    Uri url = Uri.parse('http://10.0.2.2:8000/user/login/kakao/');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type':
            'application/x-www-form-urlencoded', //'application/x-www-form-urlencoded',
      },
      body: <String, String?>{
        'uid': user.id.toString(),
        'email': userinfo.email,
        'nickname': userinfo.nickname,
      },
    );
  }
}
