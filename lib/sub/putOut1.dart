import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/sub/putOut2.dart';

import '../components/custom_elecated_button.dart';

class putOutPage1 extends StatefulWidget {
  @override
  _putOutPage1 createState() => _putOutPage1();
}

class _putOutPage1 extends State<putOutPage1> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              '내 놓고 싶으신가요?',
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
              margin: EdgeInsets.all(20),
              //모든 외부 면에 여백
              padding: EdgeInsets.all(10),
              //모든 내부 면에 여백
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
                    '내 공간을 내놓고 싶으신 분',
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
                        '내 공간 내놓기를 위한 약관동의',
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
                              builder: (context) => putOutPage2()));
                    },
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
