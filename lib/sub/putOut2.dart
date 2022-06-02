import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/src/components/custom_elecated_button.dart';
import 'package:flutter_application/src/components/custom_text_form_field.dart';
import 'package:flutter_application/sub/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';
import 'package:flutter_application/data/putOutBoard.dart';

import '../main.dart';
import '../util/validator_util.dart';
import 'imageUpload.dart';

import 'package:http/http.dart' as http;

class putOutPage2 extends StatefulWidget {
  @override
  _putOutPage2 createState() => _putOutPage2();
}

class _putOutPage2 extends State<putOutPage2> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _price = TextEditingController();
  final _floor = TextEditingController();
  final _deposit = TextEditingController();
  final _area = TextEditingController();

  dynamic discussion = 1;
  dynamic client;
  dynamic sort;
  dynamic count;
  dynamic range;
  dynamic facilities = List<bool>.filled(12, false);
  dynamic facilities_result = <int>[];
  var imagePath;

  bool _isChecked = false;

  //주소
  String postCode = '-';
  String address = '-';
  String latitude = '-';
  String longitude = '-';
  String kakaoLatitude = '-';
  String kakaoLongitude = '-';
  String addressName = '';
  final _detailAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              '내 공간 내놓기',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                '공간정보를 입력해주세요.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CustomTextFormField(
                controller: _name,
                hint: "이름",
                funValidator: validateContent(),
              ),
              CustomTextFormField(
                controller: _contact,
                hint: "연락처",
                funValidator: validateContent(),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => KpostalView(
                            useLocalServer: true,
                            localPort: 8080,
                            kakaoKey: '914bf746372c7d98a25dc1582feaabd0',
                            callback: (Kpostal result) {
                              setState(() {
                                postCode = result.postCode;
                                address = result.address;
                                latitude = result.latitude.toString();
                                longitude = result.longitude.toString();
                                kakaoLatitude = result.kakaoLatitude.toString();
                                kakaoLongitude =
                                    result.kakaoLongitude.toString();
                              });
                            },
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text(
                      '주소검색',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                    '${address}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
              CustomTextFormField(
                controller: _detailAddress,
                hint: "상세주소",
                funValidator: validateContent(),
              ),
              Text(
                '※ 상가, 점포가 2개 이상일 경우, 대표 상가, 점포 1개만 입력',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              CustomTextFormField(
                controller: _area,
                hint: "면적",
                funValidator: validateContent(),
                keyboardType: TextInputType.number,
              ),
              CustomTextFormField(
                controller: _floor,
                hint: "층",
                funValidator: validateContent(),
                keyboardType: TextInputType.number,
              ),
              CustomTextFormField(
                controller: _deposit,
                hint: "희망 보증금(원)",
                funValidator: validateContent(),
                keyboardType: TextInputType.number,
              ),
              CustomTextFormField(
                controller: _price,
                hint: "희망 월세(원)",
                funValidator: validateContent(),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: _isChecked,
                      activeColor: Colors.white,
                      checkColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                          discussion = 2;
                        });
                      }),
                  Text(
                    '보증금/월세 협의 가능',
                  ),
                ],
              ),
              Text(
                '\n의뢰인',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                children: <Widget>[
                  ElevatedButton(
                      child: Text(
                        '건물주',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        client = 1;
                      }),
                  ElevatedButton(
                      child: Text(
                        '가게주',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        client = 2;
                      }),
                ],
              ),
              Text(
                '\n원하시는 거래 종류',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                children: <Widget>[
                  ElevatedButton(
                      child: Text(
                        '전체',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        sort = 1;
                      }),
                  ElevatedButton(
                      child: Text(
                        '월세',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        sort = 2;
                      }),
                  ElevatedButton(
                      child: Text(
                        '전세',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        sort = 3;
                      }),
                ],
              ),
              Text(
                '\n내놓으실 공간 갯수',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                children: <Widget>[
                  ElevatedButton(
                      child: Text(
                        '1개',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        count = 1;
                      }),
                  ElevatedButton(
                      child: Text(
                        '2개',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        count = 2;
                      }),
                  ElevatedButton(
                      child: Text(
                        '3개+',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {
                        count = 3;
                      }),
                ],
              ),
              Text(
                '\n공간 사용범위',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  child: Text(
                    '상가, 점포로만 사용하는 게 좋아요',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    range = 1;
                  }),
              ElevatedButton(
                  child: Text(
                    '상가, 점포와 사무실 둘 다 사용 가능해요',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    range = 2;
                  }),
              Text(
                '\n시설정보',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[1],
                      onChanged: (value) {
                        setState(() {
                          facilities[1] = value!;
                        });
                      }),
                  Text(
                    '즉시 입주가능',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[2],
                      onChanged: (value) {
                        setState(() {
                          facilities[2] = value!;
                        });
                      }),
                  Text(
                    '내부 화장실',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[3],
                      onChanged: (value) {
                        setState(() {
                          facilities[3] = value!;
                        });
                      }),
                  Text(
                    '남녀 화장실 구분',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[4],
                      onChanged: (value) {
                        setState(() {
                          facilities[4] = value!;
                        });
                      }),
                  Text(
                    '개별난방',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[5],
                      onChanged: (value) {
                        setState(() {
                          facilities[5] = value!;
                        });
                      }),
                  Text(
                    '엘리베이터',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[6],
                      onChanged: (value) {
                        setState(() {
                          facilities[6] = value!;
                        });
                      }),
                  Text(
                    '최근 리모델링',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[7],
                      onChanged: (value) {
                        setState(() {
                          facilities[7] = value!;
                        });
                      }),
                  Text(
                    '주차대수',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[8],
                      onChanged: (value) {
                        setState(() {
                          facilities[8] = value!;
                        });
                      }),
                  Text(
                    '테라스',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[9],
                      onChanged: (value) {
                        setState(() {
                          facilities[9] = value!;
                        });
                      }),
                  Text(
                    '루프탑',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[10],
                      onChanged: (value) {
                        setState(() {
                          facilities[10] = value!;
                        });
                      }),
                  Text(
                    '샵인샵',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: facilities[11],
                      onChanged: (value) {
                        setState(() {
                          facilities[11] = value!;
                        });
                      }),
                  Text(
                    '24시간 개방',
                  ),
                ],
              ),
              ListTile(
                title: Text('\n사진업로드\n'),
                onTap: () async {
                  imagePath = await Get.to(ImageUpload());
                },
              ),
              CustomElevatedButton(
                  text: "신청하기",
                  funPageRoute: () async {
                    if (_formKey.currentState!.validate()) {
                      savePutOut();
                      flutterToast();
                      Get.back();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> savePutOut() async {
    for (var i = 1; facilities[i]; i++) {
      stdout.writeln("This log is using stdout");

      if (facilities[i]) {
        facilities_result.add(i);
      }
    }

    Uri url = Uri.parse('http://10.0.2.2:8000/board/new_post/put_out/');

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type':
            'application/x-www-form-urlencoded', //'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'name': _name.text,
        'contact': _contact.text,
        'area': _area.text,
        'floor': _floor.text,
        'deposit': _deposit.text,
        'price': _price.text,
        'discussion': discussion.toString(),
        'client': client.toString(),
        'sort': sort.toString(),
        'count': count.toString(),
        'range': range.toString(),
        'facilities': facilities_result.toString(),
        'images': imagePath.toString(),
        'address': address,
        'kakaoLatitude': kakaoLatitude,
        'kakaoLongitude': kakaoLongitude,
        'addressName': addressName,
        'datailAddress': _detailAddress.text,
      },
    );
  }

  void flutterToast() {
    Fluttertoast.showToast(
        msg: "신청되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
