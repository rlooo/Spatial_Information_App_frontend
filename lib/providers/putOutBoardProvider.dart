import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../data/putOutBoard.dart';

class PutOutBoardProvider extends ChangeNotifier {
  List<PutOutBoard> _putOutBoard = [];
  UnmodifiableListView<PutOutBoard> get allSolution =>
      UnmodifiableListView(_putOutBoard);

  fetchPutOutBoard() async {
    final response = await http
        .get(Uri.parse("http://localhost:8000/board/new_post/put_out/"));
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      _putOutBoard =
          data.map<PutOutBoard>((json) => PutOutBoard.fromJson(json)).toList();
      notifyListeners();
    }
  }
}
