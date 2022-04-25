import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoLoginApp extends StatelessWidget {
  const KakaoLoginApp({Key? key}) : super(key: key);

  void _get_user_info() async {
    try {
      User user = await UserApi.instance.me();
      print('사용자 정보 요청 성공'
          '\n회원번호: ${user.id}'
          '\n닉네임: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
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
                child: CupertinoButton(
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
                      // 카카오톡 설치 여부 확인
                      // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
                      if (await isKakaoTalkInstalled()) {
                        try {
                          await UserApi.instance.loginWithKakaoTalk();
                          print('카카오톡으로 로그인 성공');
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
                          } catch (error) {
                            print('카카오계정으로 로그인 실패 $error');
                          }
                        }
                      } else {
                        try {
                          await UserApi.instance.loginWithKakaoAccount();
                          print('카카오계정으로 로그인 성공');
                        } catch (error) {
                          print('카카오계정으로 로그인 실패 $error');
                        }
                      }
                    }))));
  }
}
