import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  late WebViewController _mapController;

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
                      markerImageURL:
                          'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
                      customScript: ''';

                                        var markers = [];
                                        var overlay;

                                        function addMarker(position) {

                                          var marker = new kakao.maps.Marker({position: position});

                                          marker.setMap(map);

                                          markers.push(marker);
                                        }

                                        function displayMarker(latitude, longitude, index, price, deposit, area, floor, range) {

                                          const content = '<div class="wrap">' + 
            '    <div class="info">' + 
            '        <div class="title">' + 
            '            카카오 스페이스닷원' + 
            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
            '        </div>' + 
            '        <div class="body">' + 
            '            <div class="img">' +
            '                <img src="https://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
            '           </div>' + 
            '            <div class="desc">' + 
            '                <div class="ellipsis">' + '보증금 '+ price + '만원 /' + '월세 '+ deposit + '만원'+ '</div>' + 
            '                <div class="jibun ellipsis">' + '면적 '+ area + '평  ' + '층 '+ floor + '층'+ '</div>' + 
            '                <div class="jibun ellipsis">'+'사용면적 '+range+'</div>' + 
            '            </div>' + 
            '        </div>' + 
            '    </div>' +    
            '</div>';
                      
                                          const position = new kakao.maps.LatLng(latitude, longitude);

                                          overlay = new kakao.maps.CustomOverlay({
                                          map:map,
                                          position: position,
                                          content: content,
                                          yAnchor: 1
                                        });

                                          addMarker(new kakao.maps.LatLng(latitude, longitude));

                                          // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
                                          kakao.maps.event.addListener(markers[index], 'click', (function(i) {
                                            return function(){
                                              onTapMarker.postMessage(i);
                                              overlay.setMap(map);
                                            };
                                          })(index));

                                          // //오버레이를 클릭했을 때 커스텀 오버레이를 표시합니다
                                          // kakao.maps.event.addListener(markers[index], 'click', (function(i) {
                                          //   return function(){
                                          //     onTapMarker.postMessage(i);
                                          //     overlay.setMap(map);
                                          //   };
                                          // })(index));
                                        }

                                          // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
                                          function closeOverlay() {
                                            overlay.setMap(null);     
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
          "displayMarker(${buildingArray[i].latitude}, ${buildingArray[i].longitude}, $i, ${buildingArray[i].price}, ${buildingArray[i].deposit}, ${buildingArray[i].area}, ${buildingArray[i].floor}, ${buildingArray[i].range})\n";
    }

    return displayMarker;
  }

  String _test2() {
    String customOverlay = '';
    for (int i = 0; i < buildingArray.length; i++) {
      customOverlay +=
          "setCustomOverlay(${buildingArray[i].latitude}, ${buildingArray[i].longitude}, $i)\n";
    }

    return customOverlay;
  }
}
