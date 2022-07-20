import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/src/components/custom_elecated_button.dart';
import 'package:flutter_application/src/components/custom_text_form_field.dart';
import 'package:flutter_application/src/components/custom_textarea.dart';
import 'package:flutter_application/src/controller/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as _get;
import 'package:image_picker/image_picker.dart';
import 'package:kpostal/kpostal.dart';

import '../util/validator_util.dart';
import 'imageUpload.dart';

import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;

class putOutPage2 extends StatefulWidget {
  @override
  _putOutPage2 createState() => _putOutPage2();
}

class _putOutPage2 extends State<putOutPage2> {
  final UserController userController = _get.Get.put(UserController());

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _price = TextEditingController();
  final _floor = TextEditingController();
  final _deposit = TextEditingController();
  final _area = TextEditingController();
  final _remarks = TextEditingController();

  dynamic discussion = 1;
  dynamic client;
  dynamic sort;
  dynamic count;
  dynamic range;
  dynamic facilities = List<bool>.filled(12, false);
  dynamic facilities_result = <int>[];

  List<XFile> pickedImgs = [];

  bool _isChecked = false;
  List<bool> _selections1 = List.generate(2, (index) => false);
  List<bool> _selections2 = List.generate(3, (index) => false);
  List<bool> _selections3 = List.generate(3, (index) => false);
  List<bool> _selections4 = List.generate(2, (index) => false);

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
                hint: "연락처( - 없이 입력하세요.)",
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
                                kakaoLongitude = result.kakaoLongitude.toString();
                              });
                            },
                          ),
                        ),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ))),
                    child: Text(
                      '주소검색',
                      style: TextStyle(color: Colors.black),
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
                hint: "면적(평)",
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
                hint: "희망 보증금(만원)",
                funValidator: validateContent(),
                keyboardType: TextInputType.number,
              ),
              CustomTextFormField(
                controller: _price,
                hint: "희망 월세(만원)",
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
              Center(
                child: ToggleButtons(
                  borderRadius:BorderRadius.circular(10),
                  children: <Widget>[
                    Text(
                      '건물주',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '가게주',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      if (index == 0) {
                        _selections1[1] = false;
                      } else {
                        _selections1[0] = false;
                      }
                      _selections1[index] = !_selections1[index];
                      client = index + 1;
                    });
                  },
                  isSelected: _selections1,
                ),
              ),
              Text(
                '\n원하시는 거래 종류',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Center(
                child: ToggleButtons(
                  borderRadius:BorderRadius.circular(10),
                  children: <Widget>[
                    Text(
                      '전체',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '월세',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '전세',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      if (index == 0) {
                        _selections2[1] = false;
                        _selections2[2] = false;
                      } else if (index == 1) {
                        _selections2[0] = false;
                        _selections2[2] = false;
                      } else {
                        _selections2[0] = false;
                        _selections2[1] = false;
                      }
                      _selections2[index] = !_selections2[index];
                      sort = index + 1;
                    });
                  },
                  isSelected: _selections2,
                ),
              ),
              Text(
                '\n내놓으실 공간 갯수',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Center(
                child: ToggleButtons(
                  borderRadius:BorderRadius.circular(10),
                  children: <Widget>[
                    Text(
                      '1개',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '2개',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '3개+',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      if (index == 0) {
                        _selections3[1] = false;
                        _selections3[2] = false;
                      } else if (index == 1) {
                        _selections3[0] = false;
                        _selections3[2] = false;
                      } else {
                        _selections3[0] = false;
                        _selections3[1] = false;
                      }
                      _selections3[index] = !_selections3[index];
                      count = index + 1;
                    });
                  },
                  isSelected: _selections3,
                ),
              ),
              
              Text(
                '\n공간 사용범위',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Center(
                child: ToggleButtons(
                  borderRadius:BorderRadius.circular(10),
                  children: <Widget>[
                    
                    Text(
                      '  상가, 점포로만  \n  사용하는 게 좋아요  ',textAlign:TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '  상가, 점포와 사무실  \n  둘 다 사용 가능해요  ',textAlign:TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      if (index == 0) {
                        _selections4[1] = false;
                      } else {
                        _selections4[0] = false;
                      }
                      _selections4[index] = !_selections4[index];
                      range = index + 1;
                    });
                  },
                  isSelected: _selections4,
                ),
              ),
              
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
              CustomTextArea(
                controller: _remarks,
                hint: "비고란",
                funValidator: validateRemarks(),
              ),
              ListTile(
                title: Text('\n사진업로드\n'),
                onTap: () async {
                  pickedImgs = await _get.Get.to(ImageUpload());
                },
              ),
              CustomElevatedButton(
                  text: "신청하기",
                  funPageRoute: () async {
                    if (_formKey.currentState!.validate()) {
                      // savePutOut();
                      savePutOut2();
                      flutterToast();
                      _get.Get.back();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> savePutOut2() async {
    for (var i = 1; facilities[i]; i++) {
      stdout.writeln("This log is using stdout");

      if (facilities[i]) {
        facilities_result.add(i);
      }
    }

    FormData _formData;
    final List<MultipartFile> _files = pickedImgs.map((img) => MultipartFile.fromFileSync(img.path, contentType: MediaType("image", "jpg"))).toList();

    _formData = FormData.fromMap({
      'file': _files,
      'uid': userController.uid.value,
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
      'address': address,
      'kakaoLatitude': kakaoLatitude,
      'kakaoLongitude': kakaoLongitude,
      'addressName': addressName,
      'detailAddress': _detailAddress.text,
      'remarks': _remarks.text,
    });

    Dio dio = Dio();

    dio.options.contentType = 'multipart/form-data';

    final res = await dio.post(
      'http://10.0.2.2:8000/board/new_post/put_out2/',
      data: _formData,
    );

    if (res.statusCode == 200) {
      print(res.data);
    } else {
      print('eeerror');
    }
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
