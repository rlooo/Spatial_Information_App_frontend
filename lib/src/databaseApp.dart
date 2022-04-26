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

  Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;

    return await initDB();
  }
  
  initDB() async {
    String path = join(await getDatabasesPath(), 'spartialdata_db.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  //테이블 만들기
  void _onCreate(Database db, int version) {
    //wish 테이블
    db.execute('''
      CREATE TABLE wishTable (
      no INTEGER PRIMARY KEY AUTOINCREMENT,
      putout_id INTEGER)''');
  }

  //INSERT
  Future<void> insertWish(Wish wish) async {
    // 이전에 만들었던 db의 값을 가져온다.
    final db = await database;

    await db.insert(
      'wishTable', // 테이블명
      wish.toMap(), // 내부 db에 맵핑을 한 데이터를 넣는다.
    );
  }

  //Read
  getWish(int putout_id) async {
    final db = await database;

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
    final db = await database;

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
  Future<void> deleteWish(int putout_id) async {
    final db = await database;

    await db.delete(
    'wishTable',
    where: 'putout_id = ?',
    whereArgs: [putout_id]
    );
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
