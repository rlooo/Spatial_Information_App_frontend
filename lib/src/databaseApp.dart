import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/wish.dart';
import '../main.dart';
import '../sub/home.dart';

class DatabaseApp extends StatelessWidget {
  // 데이터베이스를 담아두기 위한 변수(값이 있으면 중복 호출하지 않음)

  var _spartialdata_db;

  initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'spartialdata_db.db'), // 경로를 저장한다.
      onCreate: (db, version) =>
          createTable(db), //onCreate 인자의 생성한 디비를 넣어주어 테이블을 생성한다.
      version: 1, //데이터베이스의 업그레이드와 다운그레이드를 함으로써, 수정하기 위한 경로를 제공
    );
  }

  // 데이터베이스 값 반환하기
  Future<Database> get spartialdata_db async {
    // 데이터베이스가 있으면 중복호출하지 않기 위해
    // 변수에 있는 데이터베이스를 그대로 반환한다.
    if (_spartialdata_db != null) return _spartialdata_db;

    _spartialdata_db = await initDatabase();
    return _spartialdata_db;
  }

  //테이블 만들기
  void createTable(Database db) {
    //wish 테이블
    db.execute('''
      CREATE TABLE wishTable (
      no INTEGER PRIMARY KEY AUTOINCREMENT,
      putout_id INTEGER)''');
  }

  //INSERT
  insertWish(Wish wish) async {
    // 이전에 만들었던 db의 값을 가져온다.
    final db = await spartialdata_db;

    await db.insert(
      'wishTable', // 테이블명
      wish.toMap(), // 내부 db에 맵핑을 한 데이터를 넣는다.
      conflictAlgorithm: ConflictAlgorithm.replace, //기본키 중복시 대체
    );
  }

  //Read
  getWish(int putout_id) async {
    final db = await spartialdata_db;
    var res = await db
        .rawQuery('SELECT * FROM wishTable WHERE putout_id = ?', [putout_id]);
    return res.isNotEmpty
        ? Wish(
            no: res.first['no'] as int,
            putout_id: res.first['putout_id'] as int)
        : Null;
  }

  //Read All
  Future<List<Wish>> getAllWish() async {
    final db = await spartialdata_db;

    // 모든 Wish를 얻기 위해 테이블에 질의한다.
    var res = await db.rawQuery('SELECT * FROM wishTable');

    List<Wish> list = res.isNotEmpty
        ? res
            .map((c) =>
                Wish(no: c['no'] as int, putout_id: c['putout_id'] as int))
            .toList()
        : [];

    return list;
  }

  //Delete
  deleteWish(int putout_id) async {
    final db = await spartialdata_db;

    var res = await db
        .rawDelete('DELETE FROM wishTable WHERE putout_id = ?', [putout_id]);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    // Future<Database> database = initDatabase();
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Firebase load fail"),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MyHomePage();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
