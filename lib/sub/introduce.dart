import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroducePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              '공간나눔사업 설명 및 안내',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              //모든 내부 면에 여백
              height: 350,
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '\n터새로이와 함께하는 공간나눔사업이란?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Text(
                    '\n공간나눔사업은 지역 내 창업 예정자를 대상으로 컨설팅 및 교육을 통해 창업 역량을 강화하고, 리모델링 및 시설비를 보조하여 안정적인 정착을 도모하는 지원사업입니다. \n'
                    '또한 건물(토지)주와 창업자 간 상생협약을 통해 지역 내 유휴공간을 효율적으로 관리하고 지역 활력을 재고하는 사업입니다.',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.download, color: Colors.white, size: 18),
                          Text('공고문 다운로드'),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Colors.white), // border line color
                        )),
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              //모든 내부 면에 여백
              height: 200,
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Color(0xffF1F0F0),
              ),
              child: Column(children: <Widget>[
                Text(
                  '모집분야\n',
                  style: Theme.of(context).textTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '- 창업자 : 세종시 조치원읍 상1리, 상2리 내에 사업장을 가지고 있거나 가질 예정인 창업자 및 사업자(3년 이내 창업)\n- 건물주 : 세종시 조치원읍 상1리, 상2리 내 빈점포 소유주\n※ 도시재생사업과 관련되어 지역사회에 기여하는 업종 우대, 청년 사업자 우대',
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.all(10),
              //모든 내부 면에 여백
              height: 150,
              margin: EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Color(0xffF1F0F0),
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    '지원계획\n',
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '- 점포당 최대 2천만 원 규모\n※ 이중 지원 불가',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('전화상담'),
        icon: const Icon(Icons.support_agent),
      ),
    );
  }
}
