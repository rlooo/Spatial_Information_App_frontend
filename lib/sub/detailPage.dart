import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/putOutBoard.dart';
import 'package:flutter_application/data/wish.dart';
import 'package:flutter_application/sub/applySpace.dart';
import 'package:flutter_application/sub/streetView.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import 'package:get/get.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../src/databaseApp.dart';
import 'lookFor.dart';

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
  var pk = Get.arguments;

  var id;
  var address;
  var area;
  var floor;
  var deposit;
  var price;
  var discussion;
  var range;
  var facility;
  var images;
  var latitude;
  var longitude;

  bool _isPressed = false;
  final _model = DatabaseApp(); //데이터베이스

  var _mapController;

  void setWishButton(int putout_id) {
    if (_model.getWish(putout_id) != Null) {
      print(_model.getWish(putout_id));
      _isPressed = true;
    } else
      _isPressed = false;
  }

  void wish(bool isPressed, int putout_id) {
    if (isPressed == true) {
      _model.insertWish(Wish(putout_id: putout_id));
      print("찜");
    } else {
      if (_model.getWish(putout_id) != Null) {
        _model.deleteWish(putout_id);
        print("삭제");
      }
    }
  }

  @override
  initState() {
    setWishButton(pk);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: fetchPutOutBoard(pk),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            id = snapshot.data!.id.toString();
            address = snapshot.data!.address;
            area = snapshot.data!.area.toString();
            floor = snapshot.data!.floor.toString();
            deposit = snapshot.data!.deposit.toString();
            price = snapshot.data!.price.toString();
            discussion = snapshot.data!.discussion;
            range = snapshot.data!.range;
            facility = snapshot.data!.facility;
            images = snapshot.data!.images;
            latitude = snapshot.data!.latitude;
            longitude = snapshot.data!.longitude;

            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                  '등록번호 ' + id,
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: _isPressed
                        ? Icon(
                            Icons.favorite,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                    onPressed: () {
                      setState(() {
                        _isPressed = !_isPressed;
                        wish(_isPressed, pk);
                        print('favorite button is clicked');
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
                            Text('신규입점·1층·9평',
                                style: Theme.of(context).textTheme.subtitle2),
                            Text(
                              '${address}',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            Text('근린상가·서초동·조회63',
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
                                area + '㎡',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '층 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                floor + '층',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '희망금액 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                '보증금 ' + deposit + '원, 월세 ' + price + '원',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '금액조정 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                discussion,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '사용범위 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                range,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ]),
                            Row(children: <Widget>[
                              Text(
                                '시설정보 ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                facility,
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
                            Get.to(() => StreetViewPanoramaInitDemo(), arguments: [latitude, longitude]);
                          }),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Get.to(() => ApplySpacePage(), arguments: [id, address]);
                },
                label: const Text('신청하기'),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
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
