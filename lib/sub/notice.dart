import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/notice.dart';

import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

List<Notice> noticeArray = [];

Future<List<Notice>?> fetchNotice() async {
  final response =
      await http.get(Uri.parse('http://10.0.2.2:8000/board/notice/list'));
  if (response.statusCode == 200) {
    final notices = json.decode(response.body);

    List<Notice> entries = [];
    for (var notice in notices) {
      entries.add(Notice(
        title: notice['title'],
        content: notice['content'],
        link: notice['link'],
        created_at: notice['created_at'],
      ));
    }
    return entries;
  }

  throw Exception('데이터 수신 실패');
}

class NoticePage extends StatefulWidget {
  @override
  _NoticePage createState() => _NoticePage();
}

class _NoticePage extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchNotice(),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.hasData) {
            noticeArray = snapshot.data;
            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      const Text(
                        '공지사항',
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
                    child: Divider(
                        thickness: 0.5, height: 0.5, color: Colors.grey),
                  ),
                ),
                body: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: noticeArray.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(children: <Widget>[
                          Text('${noticeArray[index].title}'),
                          Text('${noticeArray[index].created_at}'),
                          Text('${noticeArray[index].content}'),
                          TextButton(
                            onPressed: () {
                              _launchUrl('${noticeArray[index].link}');
                            },
                            child: Text('${noticeArray[index].link}'),
                          ),
                        ]));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        });
  }

  void _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}
