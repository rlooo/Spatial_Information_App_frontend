import 'package:firebase_database/firebase_database.dart';

class QnA {
  String? title;
  String? content;
  String? answer;
  String? author;
  var created_at;

  QnA({this.title, this.content, this.answer, this.created_at, this.author});

  factory QnA.fromJson(Map<String, dynamic> json) {
    return QnA(title: json['title'], content: json['content'], answer: json['answer'], created_at: json['created_at'], author: json['author']);
  }

  toJson() => {
        'title': title,
        'content': content,
        'answer': answer,
        'created_at': created_at,
        'author':author
      };

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'answer': answer,
      'created_at': created_at,
      'author':author
    };
  }
}
