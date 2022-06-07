import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/data/putOutBoard.dart';
import 'package:flutter_application/src/controller/putout_controller.dart';
import 'package:flutter_application/sub/applySpace.dart';
import 'package:flutter_application/sub/streetView.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

const String kakaoMapKey = '914bf746372c7d98a25dc1582feaabd0';
Future<PutOutBoard?> fetchPutOutBoard(var pk) async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/board/detail/$pk'));
  if (response.statusCode == 200) {
    final boardMap = jsonDecode(utf8.decode(response.bodyBytes));
    return PutOutBoard.fromJson(boardMap);
  }

  throw Exception('데이터 수신 실패');
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  final PutOutController putoutController = Get.put(PutOutController());
  var pk = Get.arguments;

  bool _isPressed = false;
  var _mapController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: fetchPutOutBoard(pk),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            PutOutBoard putout = snapshot.data;

            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                  '등록번호 ' + putout.id.toString(),
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: putout.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        putoutController.updateFavoritePutOut(putout);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      //공유 버튼
                      Icons.share,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // 아이콘 버튼 실행
                      print('Share button is clicked');
                    },
                  ),
                ],
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(0.5),
                  child:
                      Divider(thickness: 0.5, height: 0.5, color: Colors.grey),
                ),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.asset(
                        'images/kakao1.jpg',
                        height: 300,
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        padding: EdgeInsets.all(10), //모든 내부 면에 여백
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${putout.facility}',
                                style: Theme.of(context).textTheme.subtitle2),
                            Text(
                              '${putout.address}',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            Text('${putout.detail_address}',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0)),
                          ],
                        ),
                      ),
                      Divider(thickness: 1, height: 0.5, color: Colors.grey),
                      Container(
                        padding: EdgeInsets.all(10), //모든 내부 면에 여백
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '매물 세부 정보\n',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Row(children: <Widget>[
                              Text(
                                '면적 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.area.toString() + '㎡',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '층 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.floor.toString() + '층',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '희망금액 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                '보증금 ' +
                                    putout.deposit.toString() +
                                    '만원, 월세 ' +
                                    putout.price.toString() +
                                    '만원',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '금액조정 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.discussion,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '사용범위 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.range,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '시설정보 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.facility,
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ]),
                          ],
                        ),
                      ),
                      Divider(thickness: 1, height: 0.5, color: Colors.grey),
                      Container(
                        padding: EdgeInsets.all(10), //모든 내부 면에 여백
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '건축물 정보\n',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Row(children: <Widget>[
                              Text(
                                '대지면적 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.platArea.toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '건축면적 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.archArea.toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '건폐율 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.bcRat.toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '용적율 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.vlRat.toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '층수 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                '지하' + putout.ugrndFlrCnt.toString() + '층 ~ ',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                '지상' + putout.grndFlrCnt.toString() + '층',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '주용도 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.mainPurpsCdNm,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '기타용도 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.etcPurps,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '구조 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.strctCdNm,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '총주차수 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                putout.totPkngCnt.toString(),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                          ],
                        ),
                      ),
                      Divider(thickness: 1, height: 0.5, color: Colors.grey),
                      ElevatedButton(
                          child: Text(
                            '로드뷰',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {
                            Get.to(() => StreetViewPanoramaInitDemo(),
                                arguments: [putout.latitude, putout.longitude]);
                          }),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Color(0xff662D91),
                onPressed: () {
                  Get.to(() => ApplySpacePage(),
                      arguments: [putout.id.toString(), putout.address]);
                },
                label: const Text('신청하기'),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        });
  }

  // void wish(bool isPressed) {
  //   if (isPressed == true) {
  //     insertWish(widget.db!, putoutData);
  //   }
  // }

  // void insertWish(Future<Database> db, PutOutBoard info) async {
  //   final Database database = await db;
  //   await database
  //       .insert('wish', info.toMap(),
  //           conflictAlgorithm: ConflictAlgorithm.replace)
  //       .then((value) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('즐겨찾기에 추가되었습니다')));
  //   });
  // }
}
