import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application/data/putOutBoard.dart';
import 'package:flutter_application/sub/kakaoLogin.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sqflite/sqflite.dart';

import 'detailPage.dart';

bool token = false;

hasToken() async {
  if (await AuthApi.instance.hasToken()) {
    try {
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
      print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
      token = true;
    } catch (error) {
      if (error is KakaoException && error.isInvalidTokenError()) {
        print('토큰 만료 $error');
        token = false;
      } else {
        print('토큰 정보 조회 실패 $error');
        token = false;
      }
    }
  }
}

class WishApp extends StatefulWidget {
  // final Future<Database>? db;
  // WishApp({this.db});

  @override
  _WishApp createState() => _WishApp();
}

class _WishApp extends State<WishApp> {
  Future<List<PutOutBoard>>? _wishList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hasToken();
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //     length: 3,
    // child:

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
          // bottom: TabBar(
          //   tabs: <Widget>[
          //     Tab(
          //         icon: Text(
          //       '최근 본 매물',
          //       style: TextStyle(color: Colors.black),
          //     )),
          //     Tab(
          //         icon: Text(
          //       '연락한 매물',
          //       style: TextStyle(color: Colors.black),
          //     )),
          //     Tab(
          //         icon: Text(
          //       '찜한 매물',
          //       style: TextStyle(color: Colors.black),
          //     )),
          //   ],
          // ),
        ),
        body: token
            ? Container(
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
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    textAlign: TextAlign.start,
                                  ),
                                  Text(
                                    '서울 중랑구 중랑역로 13길 2',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  Text('근린상가·서초동·조회63',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 10.0)),
                                  Row(children: <Widget>[
                                    Text('       월세 ',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.0)),
                                    Text('1000만원',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0))
                                  ]),
                                  Row(children: <Widget>[
                                    Text('       보증금 ',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.0)),
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
              )
            : Container(
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
                        color: Colors.red,
                        onPressed: () async {
                          Get.to(() => KakaoLoginApp());
                        },
                      ),
                    ],
                  ),
                ),
              )

        // TabBarView(
        //   children: <Widget>[Lately(), Contact(), Wish()],
        // )
        );
    // );
  }
}

// class Wish extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Center(
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Container(
//                       margin: EdgeInsets.all(10),
//                       width: 100.0,
//                       height: 100.0,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.black, width: 1),
//                           image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: AssetImage('images/kakao1.jpg')))),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       // 상세페이지 이동은 TourDetailPage를 재사용하도록 합니다
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => DetailPage()));
//                     },
//                     child: Container(
//                       child: Column(
//                         children: <Widget>[
//                           Text(
//                             '신규입점·1층·9평',
//                             style: Theme.of(context).textTheme.subtitle2,
//                             textAlign: TextAlign.start,
//                           ),
//                           Text(
//                             '대로변무권리,신호등앞,투썸앞,부동산자리,음식점가능,유동터짐',
//                             style: Theme.of(context).textTheme.headline1,
//                           ),
//                           Text('근린상가·서초동·조회63',
//                               style: TextStyle(
//                                   color: Colors.grey, fontSize: 10.0)),
//                           Text('월세 : 250만',
//                               style: Theme.of(context).textTheme.bodyText1),
//                           Text(
//                             '보증금 : 3000만',
//                             style: Theme.of(context).textTheme.bodyText1,
//                           ),
//                           Text('권리금 : 없음',
//                               style: Theme.of(context).textTheme.bodyText1),
//                         ],
//                       ),
//                       width: MediaQuery.of(context).size.width - 150,
//                     ),
//                   )
//                 ],
//               ),
//             ])),
//       ),
//     );
//   }
// }

// class Contact extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

// class Lately extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }

  // Future<List<PutOutBoard>> getPutouts() async {
  //   final Database database = await widget.db!;
  //   final List<Map<String, dynamic>> maps = await database.query('wish');

  //   return List.generate(maps.length, (i) {
  //     return PutOutBoard(
  //         id: maps[i]['id'].toString,
  //         author: maps[i]['author'].toString(),
  //         name: maps[i]['name'].toString(),
  //         contact: maps[i]['contact'].toString(),
  //         address: maps[i]['address'].toString(),
  //         area: maps[i]['area'].toString(),
  //         floor: maps[i]['floor'].toString(),
  //         deposit: maps[i]['deposit'].toString(),
  //         price: maps[i]['price'].toString(),
  //         discussion: maps[i]['discussion'].toString(),
  //         client: maps[i]['client'].toString(),
  //         sort: maps[i]['sort'].toString(),
  //         count: maps[i]['count'].toString(),
  //         range: maps[i]['range'].toString(),
  //         facility: maps[i]['facility'].toString(),
  //         created_at: maps[i]['created_at'].toString());
  //   });
  // }

// }
