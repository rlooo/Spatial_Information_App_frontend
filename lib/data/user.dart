import 'package:firebase_database/firebase_database.dart';

class UserInfo {
  dynamic uid;
  String? email;
  String? nickname;

  UserInfo(this.uid, this.email, this.nickname);

  // User.fromSnapshot(DataSnapshot snapshot)
  //     : login_id = snapshot.value['login_id'],
  //       email = snapshot.value['email'],
  //       nickname = snapshot.value['nickname'],
  //       access_token = snapshot.value['access_token'],
  //       refresh_token = snapshot.value['refresh_token'],
  //       createTime = snapshot.value['createTime'];

  toJson() {
    return {
      'uid': uid,
      'email': email,
      'nickname': nickname,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nickname': nickname,
    };
  }
}
