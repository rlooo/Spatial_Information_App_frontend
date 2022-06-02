import 'package:firebase_database/firebase_database.dart';

class QnA {
  String? title;
  String? content;
  String? answer;
  var created_at;

  QnA({this.title, this.content, this.answer, this.created_at});

  factory QnA.fromJson(Map<String, dynamic> json) {
    return QnA(
      title: json['title'],
      content: json['content'],
      answer: json['answer'],
      created_at: json['created_at'],
    );
  }

  toJson() => {
        'title': title,
        'content': content,
        'answer': answer,
        'created_at': created_at,
      };

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'answer': answer,
      'created_at': created_at,
    };
  }
}
