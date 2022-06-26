import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/src/controller/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../src/components/custom_elecated_button.dart';
import '../src/components/custom_text_form_field.dart';
import '../util/validator_util.dart';

import 'package:http/http.dart' as http;

class ApplySpacePage extends StatefulWidget {
  @override
  _ApplySpacePage createState() => _ApplySpacePage();
}

class _ApplySpacePage extends State<ApplySpacePage> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  var id = Get.arguments[0];
  var address = Get.arguments[1];

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
              width: 350,
              height: 420,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '\n공간나눔사업',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  Text(
                    '내 공간을 신청하고 싶으신 분',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    child: Text(
                      '내 공간 신청하기를 위한 약관동의',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () => FlutterDialog1(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: _isChecked1,
                          activeColor: Colors.white,
                          checkColor: Colors.red,
                          onChanged: (value) {
                            setState(() {
                              _isChecked1 = value!;
                            });
                          }),
                      Text(
                        '[필수] 개인정보 수집 및 이용동의',
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ))),
                        onPressed: () => FlutterDialog2(),
                        child: Text("내용보기", style: TextStyle(fontSize: 13)),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                          value: _isChecked2,
                          activeColor: Colors.white,
                          checkColor: Colors.red,
                          onChanged: (value) {
                            setState(() {
                              _isChecked2 = value!;
                            });
                          }),
                      Text(
                        '[필수] 제3자 정보 제공 동의',
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ))),
                        onPressed: () => FlutterDialog3(),
                        child: Text("내용보기", style: TextStyle(fontSize: 13)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomElevatedButton(
                    text: "지금 신청하기",
                    funPageRoute: () async {
                      Get.to(() => NextApplySpacePage(),
                          arguments: [id.toString(), address]);
                    },
                  ),
                ],
              )),
        ]),
      ),
    );
  }

  void FlutterDialog1() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[new Text("약관동의")],
            ),
            //
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    "‘터새로이사업과 함께하는 공간나눔사업(약칭 공간나눔)’ 서비스 내 이용자 식별, 회원관리 및 서비스 제공을 위해 회원번호와 함께 (이메일주소 혹은 닉네임)님의 개인정보를 제공합니다. 정보는 서비스 탈퇴 시 지체없이 파기됩니다. 아래 동의를 거부 할 권리가 있으며, 동의를 거부할 경우 서비스 이용이 제한됩니다.\n[제공 받는 자]\n㈜마을, 상리 도시재생 현장지원센터\n[필수 제공 항목]\n프로필 정보(닉네임/프로필 사진), 카카오계정(이메일), 카카오계정(전화번호)\n[제공 목적]\n서비스 내 이용자 식별, 회원관리 및 서비스 제공을 위해\n[보유 기간]\n서비스 탈퇴 시 파기")
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("동의"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void FlutterDialog2() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[new Text("개인정보 수집 및 이용 동의")],
            ),
            //
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      "‘㈜마을'은 ‘터새로이사업과 함께하는 공간나눔사업(약칭 공간나눔)’서비스 제공을 위하여 아래와 같이 개인정보를 수집 및 이용합니다.\n정보 주체는 본 개인정보의 수집 및 이용에 관한 동의를 거부하실 권리가 있으나, 서비스 제공에 필요한 최소한의 개인정보이므로 동의를 해주셔야 서비스를 이용하실 수 있습니다.\n제공해주시는 개인정보는 '상담 안내를 요청하기 위한 용도'의 서비스 제공 목적으로 수집하며 이외 목적으로는 사용되지 않습니다.\n개인정보의 수집 이용목적\n서비스 제공 및 상담, 부정 이용 확인 및 방지, 만족도 조사(고객안심콜 등), 본인·연령 확인, 신규서비스 개발, 문의 사항 또는 불만·분쟁 처리, 맞춤형 서비스 제공, 서비스 개선에 활용, 계정도용 및 부정거래 방지\n수집하려는 개인정보의 항목\n이름, 연락처(휴대폰번호 또는 전화번호), 위치\n개인정보의 이용 및 보유기간\n서비스 제공 목적 달성 시까지 또는 회원 탈퇴 시 삭제.\n단, 전자상거래 등에서의 소비자 보호에 관한 법률 및 관계 법령에 따른 보관 의무가 있을 경우 해당 기간 동안 보관함.\n본 서비스 이용을 위해서 필수적인 동의이므로, 동의하지 않으면 해당 서비스를 이용하실 수 없습니다. 동의를 거부하는 경우에도 다른 ㈜마을 서비스의 이용에는 영향이 없습니다.")
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void FlutterDialog3() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //Dialog Main Title
            title: Column(
              children: <Widget>[new Text("개인정보 제3자 제공 동의")],
            ),
            //
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      "‘㈜마을’은 ‘터새로이사업과 함께하는 공간나눔사업(약칭 공간나눔)’서비스 제공을 위하여 아래와 같이 개인정보를 수집 및 이용합니다.\n'㈜마을'은 ‘공간나눔’ 서비스 제공을 위해서 아래와 같이 개인정보를 수집합니다.정보주체는 본 개인정보의 수집 및 이용에 관한 동의를 거부하실 권리가 있으나, 서비스 제공에 필요한 최소한의 개인 정보이므로 동의를 해주셔야 서비스를 이용하실 수 있습니다.\n- 개인정보 제공받는 자 : ㈜마을, 상리 도시재생 현장지원센터\n- 제공 정보 : 이름, 연락처, 위치\n- 목적 : 이용자가 문의한 서비스 제공 및 상담\n보유 및 이용기간 : 서비스 목적 달성 시. 단, 전자상거래 등에서의 소비자 보호에 관한 법률 및 관계 법령에 따른 보관 의무가 있을 경우 해당 기간 동안 보관함\n본 서비스 이용을 위해서 필수적인 동의이므로, 동의를 하지 않으면 해당 서비스를 이용하실 수 없습니다.\n동의를 거부하는 경우에도 다른 마을 서비스의 이용에는 영향이 없습니다.")
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("확인"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}

class NextApplySpacePage extends StatefulWidget {
  @override
  _NextApplySpacePage createState() => _NextApplySpacePage();
}

class _NextApplySpacePage extends State<NextApplySpacePage> {
  final UserController userController = Get.put(UserController());

  var buildingId = Get.arguments[0];
  var address = Get.arguments[1];

  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _contact = TextEditingController();
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
              Text('주소 : ${address}'),
              CustomTextFormField(
                controller: _name,
                hint: "이름",
                funValidator: validateContent(),
              ),
              CustomTextFormField(
                controller: _contact,
                hint: "연락처( - 없이 입력하세요.)",
                funValidator: validateContent(),
              ),
              CustomTextFormField(
                controller: _business,
                hint: "희망업종",
                funValidator: validateContent(),
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
              CustomElevatedButton(
                text: "신청하기",
                funPageRoute: () {
                  if (_formKey.currentState!.validate()) {
                    saveApply();
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

  Future<void> saveApply() async {
    Uri url = Uri.parse('http://10.0.2.2:8000/board/new_post/applyspace/');

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type':
            'application/x-www-form-urlencoded', //'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'uid': userController.uid.value,
        'buildingId': buildingId.toString(), //신청할 건물 id
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
