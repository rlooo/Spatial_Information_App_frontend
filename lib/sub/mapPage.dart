import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

import 'package:http/http.dart' as http;

import '../data/putOutBoard.dart';
import 'detailPage.dart';

const String kakaoMapKey = '914bf746372c7d98a25dc1582feaabd0';
List<PutOutBoard> buildingArray = [];

Future<List<PutOutBoard>?> fetchPutOutBoard() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/board/list'));
  if (response.statusCode == 200) {
    final buildings = json.decode(response.body);

    List<PutOutBoard> buildingMap = [];
    for (var building in buildings) {
      buildingMap.add(PutOutBoard(
        id: building['id'],
        author: building['author'],
        name: building['name'],
        contact: building['contact'],
        area: building['area'],
        floor: building['floor'],
        deposit: building['deposit'],
        price: building['price'],
        discussion: building['discussion'],
        client: building['client'],
        sort: building['sort'],
        count: building['count'],
        range: building['range'],
        facility: building['facility'],
        images: building['images'],
        latitude: building['kakaoLatitude'],
        longitude: building['kakaoLongitude'],
        address: building['address'],
        created_at: building['created_at'],
      ));
    }
    return buildingMap;
  }

  throw Exception('데이터 수신 실패');
}

class MapPage extends StatefulWidget {
  // List<PutOutBoard> Data = List.empty(growable: true);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  var _mapController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: fetchPutOutBoard(),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.hasData) {
            buildingArray = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    const Text(
                      '공간 신청하기',
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
                  child:
                      Divider(thickness: 0.5, height: 0.5, color: Colors.grey),
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KakaoMapView(
                      width: size.width,
                      height: 550,
                      kakaoMapKey: kakaoMapKey,
                      lat: 37.5968892270727,
                      lng: 127.07535510578,
                      showMapTypeControl: true,
                      showZoomControl: true,
                      mapController: (controller) {
                        _mapController = controller;
                      },
                      customOverlayStyle: '''<style>
              .customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
              </style>''',
//                       customOverlay: '''

//                       funtion setCustomOverlay(latitude, longitude, index){

//                         const content = '<div class ="label"><span class="left"></span><span class="center">카카오!</span><span class="right"></span></div>';

//                         const position = new kakao.maps.LatLng(latitude, longitude);

//                         const customOverlay = new kakao.maps.CustomOverlay({
//                         map:map,
//                         position: position,
//                         content: content,
//                         yAnchor: 1
//                       });

//                       customOverlay.setMap(map);
//                       }

//                       ${_test2()}

//                       var zoomControl = new kakao.maps.ZoomControl();
//                       map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

//                       var mapTypeControl = new kakao.maps.MapTypeControl();
//                       map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
//               ''',
                      markerImageURL:
                          'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
                      customScript: '''

                      var markers = [];

                      function addMarker(position) {

                        var marker = new kakao.maps.Marker({position: position});

                        marker.setMap(map);

                        markers.push(marker);
                      }

                      function displayMarker(latitude, longitude, index) {

                        const content = '<div class ="label"><span class="left"></span><span class="center">카카오!</span><span class="right"></span></div>';
                        const position = new kakao.maps.LatLng(latitude, longitude);
          
                        const customOverlay = new kakao.maps.CustomOverlay({
                        map:map,
                        position: position,
                        content: content,
                        yAnchor: 1
                      });

                      customOverlay.setMap(map);

                        addMarker(new kakao.maps.LatLng(latitude, longitude));

                        kakao.maps.event.addListener(markers[index], 'click', (function(i) {
                          return function(){
                            onTapMarker.postMessage(i);
                          };
                        })(index));
                      }
                        ${_test()}

                        var zoomControl = new kakao.maps.ZoomControl();
                        map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

                        var mapTypeControl = new kakao.maps.MapTypeControl();
                        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

                                ''',
                      onTapMarker: (message) async {
                        int index = int.parse(message.message);
                        Get.to(() => DetailPage(),
                            arguments: buildingArray[index].id);
                      }),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        });
  }

  String _test() {
    String displayMarker = '';
    for (int i = 0; i < buildingArray.length; i++) {
      displayMarker +=
          "displayMarker(${buildingArray[i].latitude}, ${buildingArray[i].longitude}, $i)\n";
    }

    return displayMarker;
  }

  String _test2() {
    String CustomOverlay = '';
    for (int i = 0; i < buildingArray.length; i++) {
      CustomOverlay +=
          "setCustomOverlay(${buildingArray[i].latitude}, ${buildingArray[i].longitude}, $i)\n";
    }

    return CustomOverlay;
  }
}
