import 'package:flutter/material.dart';
import 'package:flutter_application/src/binding/init_binding.dart';
import 'package:flutter_application/sub/mapPage.dart';
import 'package:flutter_application/sub/putOut1.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:path/path.dart';

import 'package:flutter_application/src/databaseApp.dart';
import 'package:flutter_application/sub/home.dart';
import 'package:flutter_application/sub/viewMore.dart';
import 'package:flutter_application/sub/favoritePage.dart';
import 'package:flutter_application/theme.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '9e4958a9e80e2426594954ea61c9c95b');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialBinding: InitBinding(),
      home: DatabaseApp(), //파이어베이스
    );
  }
}

class MyHomePage extends StatefulWidget {
  // const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller; //late 키워드를 안넣으면 에러남

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          HomeApp(),
          putOutPage1(),
          MapPage(),
          MyFavoritePage(),
          ViewMoreApp()
        ],
        controller: controller,
      ),
      bottomNavigationBar: Container(
        // color: Color(0xff662D91),
        color: Colors.white,
        child: TabBar(
          // indicatorColor: Colors.white,
          // labelColor: Colors.white,
          // unselectedLabelColor: Colors.white,
          indicatorColor: Color(0xff662D91),
          labelColor: Color(0xff662D91),
          unselectedLabelColor: Colors.grey,
          tabs: const <Tab>[
            Tab(
              icon: Icon(
                Icons.grid_view,
              ),
              text: '홈',
            ),
            Tab(
              icon: Icon(
                Icons.real_estate_agent,
              ),
              text: '나눠요',
            ),
            Tab(
              icon: Icon(
                Icons.place,
              ),
              text: '구해요',
            ),
            Tab(
              icon: Icon(
                Icons.favorite_border,
              ),
              text: '찜',
            ),
            Tab(
              icon: Icon(
                Icons.more_horiz,
              ),
              text: '더보기',
            )
          ],
          controller: controller,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
