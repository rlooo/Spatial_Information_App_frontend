import 'package:firebase_database/firebase_database.dart';

class Notice {
  String? title;
  String? content;
  var created_at;

  Notice({this.title, this.content, this.created_at});

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      title: json['title'],
      content: json['content'],
      created_at: json['created_at'],
    );
  }

  toJson() => {
        'title': title,
        'content': content,
        'created_at': created_at,
      };

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'created_at': created_at,
    };
  }
}
