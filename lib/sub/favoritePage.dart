import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application/data/putOutBoard.dart';
import 'package:flutter_application/src/controller/token_controller.dart';
import 'package:flutter_application/sub/kakaoLogin.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sqflite/sqflite.dart';

import 'detailPage.dart';

class FavoritePage extends StatelessWidget {
  final TokenController t = Get.put(TokenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text(
                '찜한 매물',
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
        body: Obx(() {
          if (t.token.value) {
            print(t.token.value);
            return Container(
              child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(10),
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('images/kakao1.jpg')))),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            // 상세페이지 이동은 TourDetailPage를 재사용하도록 합니다
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => DetailPage()));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '신규입점·1층·9평',
                                  style: Theme.of(context).textTheme.subtitle2,
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  '서울 중랑구 중랑역로 13길 2',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                Text('근린상가·서초동·조회63',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 10.0)),
                                Row(children: <Widget>[
                                  Text('       월세 ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15.0)),
                                  Text('1000만원',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0))
                                ]),
                                Row(children: <Widget>[
                                  Text('       보증금 ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 15.0)),
                                  Text('1000만원',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0))
                                ]),
                              ],
                            ),
                            width: MediaQuery.of(context).size.width - 150,
                          ),
                        )
                      ],
                    ),
                  ])),
            );
          } else {
            print(t.token.value);
            return Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("간편하게 로그인하고 다양한 서비스를 이용하세요.",
                        style: Theme.of(context).textTheme.headline2),
                    SizedBox(
                      height: 50.0,
                    ),
                    CupertinoButton(
                      child: Text(
                        "로그인",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xff662D91),
                      onPressed: () async {
                        Get.to(() => KakaoLoginApp());
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }
}
