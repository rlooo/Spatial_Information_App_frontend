import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/data/qna.dart';
import 'package:flutter_application/src/components/custom_elecated_button.dart';
import 'package:flutter_application/src/components/custom_text_form_field.dart';
import 'package:flutter_application/src/components/custom_textarea.dart';
import 'package:flutter_application/src/controller/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../util/validator_util.dart';

import 'package:http/http.dart' as http;

List<QnA> qnaArray = [];

Future<List<QnA>?> fetchQnA() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/board/qna/list'));
  if (response.statusCode == 200) {
    final qnas = json.decode(response.body);

    List<QnA> entries = [];
    for (var qna in qnas) {
      entries.add(QnA(
        title: qna['title'],
        content: qna['content'],
        created_at: qna['created_at'],
      ));
    }
    return entries;
  }

  throw Exception('데이터 수신 실패');
}

class QnAPage extends StatefulWidget {
  @override
  _QnAPage createState() => _QnAPage();
}

class _QnAPage extends State<QnAPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchQnA(),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.hasData) {
            qnaArray = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    const Text(
                      'Q&A',
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
              body: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: qnaArray.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(children: <Widget>[
                        Text('${qnaArray[index].title}'),
                        Text('${qnaArray[index].created_at}'),
                        Text('${qnaArray[index].content}'),
                        Text('${qnaArray[index].answer}'),
                      ]));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Get.to(() => NewQnAPage());
                },
                label: const Text('글쓰기'),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        });
  }
}

class NewQnAPage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  final _formKey = GlobalKey<FormState>();

  final _title = TextEditingController();
  final _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Q&A',
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
              CustomTextFormField(
                controller: _title,
                hint: "제목",
                funValidator: validateContent(),
              ),
              const SizedBox(height: 20.0),
              CustomTextArea(
                controller: _content,
                hint: "내용",
                funValidator: validateContent(),
              ),
              const SizedBox(height: 20.0),
              CustomElevatedButton(
                text: "신청하기",
                funPageRoute: () {
                  if (_formKey.currentState!.validate()) {
                    saveQnA();
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

  Future<void> saveQnA() async {
    Uri url = Uri.parse('http://10.0.2.2:8000/board/new_post/qna/');

    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type':
            'application/x-www-form-urlencoded', //'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'uid': userController.uid.value,
        'title': _title.text,
        'content': _content.text,
      },
    );
  }

  void flutterToast() {
    Fluttertoast.showToast(
        msg: "신청되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
