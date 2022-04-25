import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

import '../components/custom_elecated_button.dart';
import '../components/custom_text_form_field.dart';
import '../main.dart';
import '../util/validator_util.dart';

import 'package:http/http.dart' as http;

class LookForPage extends StatefulWidget {
  @override
  _LookForPage createState() => _LookForPage();
}

class _LookForPage extends State<LookForPage> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              '공간을 구하고 싶으신가요?',
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
      body: Center(
        child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(20), //모든 외부 면에 여백
              padding: EdgeInsets.all(10), //모든 내부 면에 여백
              width: 300,
              height: 420,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '\n공간나눔사업중개',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                  Text(
                    '내 공간을 구하고 싶으신 분',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                      child: Text(
                        '내 공간 구하기를 위한 약관동의',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      onPressed: () {}),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: _isChecked1,
                          onChanged: (value) {
                            setState(() {
                              _isChecked1 = value!;
                            });
                          }),
                      Text(
                        '[필수] 개인정보 수집 및 이용동의',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: _isChecked2,
                          onChanged: (value) {
                            setState(() {
                              _isChecked2 = value!;
                            });
                          }),
                      Text(
                        '[필수] 제3자 정보 제공 동의',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomElevatedButton(
                    text: "지금 신청하기",
                    funPageRoute: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LookForPage2()));
                    },
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}

class LookForPage2 extends StatefulWidget {
  @override
  _LookForPage2 createState() => _LookForPage2();
}

class _LookForPage2 extends State<LookForPage2> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _address = TextEditingController();
  final _price = TextEditingController();
  final _business = TextEditingController();
  final _deposit = TextEditingController();
  final _area = TextEditingController();

  var discussion = 1;

  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              '내 공간 구하기',
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
                '희망공간정보를 입력해주세요.',
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
              ),
              CustomTextFormField(
                controller: _address,
                hint: "상가, 점포 주소",
                funValidator: validateContent(),
              ),
              Text(
                '※ 상가, 점포가 2개 이상일 경우, 대표 상가, 점포 1개만 입력',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              CustomTextFormField(
                controller: _business,
                hint: "희망업종",
                funValidator: validateContent(),
              ),
              CustomTextFormField(
                controller: _area,
                hint: "희망면적",
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
              CustomElevatedButton(
                text: "신청하기",
                funPageRoute: () {
                  if (_formKey.currentState!.validate()) {
                    saveLookFor();
                    flutterToast();
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveLookFor() async {
    Uri url = Uri.parse('http://10.0.2.2:8000/board/new_post/look_for/');

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type':
            'application/x-www-form-urlencoded', //'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'name': _name.text,
        'contact': _contact.text,
        'business': _business.text,
        'area': _area.text,
        'deposit': _deposit.text,
        'price': _price.text,
        'discussion': discussion.toString(),
      },
    );
  }

  void flutterToast() {
    Fluttertoast.showToast(
        msg: "신청되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
