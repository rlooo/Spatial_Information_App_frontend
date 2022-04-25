import 'package:firebase_database/firebase_database.dart';

class User {
  String? login_id;
  String? email;
  String? nickname;
  String? access_token;
  String? refresh_token;
  String? createTime;

  User(this.login_id, this.email, this.nickname, this.access_token,
      this.refresh_token, this.createTime);

  // User.fromSnapshot(DataSnapshot snapshot)
  //     : login_id = snapshot.value['login_id'],
  //       email = snapshot.value['email'],
  //       nickname = snapshot.value['nickname'],
  //       access_token = snapshot.value['access_token'],
  //       refresh_token = snapshot.value['refresh_token'],
  //       createTime = snapshot.value['createTime'];

  toJson() {
    return {
      'login_id': login_id,
      'email': email,
      'nickname': nickname,
      'access_token': access_token,
      'refresh_token': refresh_token,
      'createTime': createTime,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'login_id': login_id,
      'email': email,
      'nickname': nickname,
      'access_token': access_token,
      'refresh_token': refresh_token,
      'createTime': createTime,
    };
  }
}
