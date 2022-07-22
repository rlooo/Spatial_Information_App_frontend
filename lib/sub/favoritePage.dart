import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/putOutBoard.dart';
import 'package:flutter_application/repository/contents_repository.dart';
import 'package:flutter_application/src/controller/favorite_controller.dart';
import 'package:flutter_application/src/controller/token_controller.dart';
import 'package:flutter_application/sub/detailPage.dart';
import 'package:flutter_application/sub/kakaoLogin.dart';
import 'package:get/get.dart';

class MyFavoritePage extends StatefulWidget {
  @override
  _MyFavoritePage createState() => _MyFavoritePage();
}

class _MyFavoritePage extends State<MyFavoritePage> {
  String serverUrl = 'http://10.0.2.2:8000';
  final TokenController t = Get.put(TokenController());
  ContentsRepository contentsRepository = ContentsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text(
                '찜한 공간',
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
            return FutureBuilder<List<dynamic>?>(
                future: _loadMyFavoriteList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>?> snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic>? datas = snapshot.data;
                    int size = datas == null ? 0 : datas.length;

                    return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> data = datas?[index];
                        return Card(
                            child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          child: Center(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        width: 100.0,
                                                        height: 100.0,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 1),
                                                            image: DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: AssetImage(
                                                                    'images/kakao1.jpg')))),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.to(
                                                            () => DetailPage(),
                                                            arguments:
                                                                data["id"]);
                                                      },
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              data["facility"],
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .subtitle2,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                            Text(
                                                              data["address"],
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline2,
                                                            ),
                                                            Text(
                                                                data[
                                                                    "detail_address"],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        10.0)),
                                                            Row(children: <
                                                                Widget>[
                                                              Text('       월세 ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          15.0)),
                                                              Text(
                                                                  data["price"]
                                                                          .toString() +
                                                                      ' 만원',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15.0))
                                                            ]),
                                                            Row(children: <
                                                                Widget>[
                                                              Text(
                                                                  '       보증금 ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          15.0)),
                                                              Text(
                                                                  data["deposit"]
                                                                          .toString() +
                                                                      ' 만원',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15.0))
                                                            ]),
                                                          ],
                                                        ),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            150,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ])),
                                        )
                                      ],
                                    )
                                  ],
                                )));
                      },
                      itemCount: size,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          thickness: 1,
                          color: Colors.grey[400],
                          height: 5,
                          indent: 16,
                          endIndent: 16,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                });
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

  Future<List<dynamic>?> _loadMyFavoriteList() async {
    return await contentsRepository.loadFavoriteContents();
  }
}
