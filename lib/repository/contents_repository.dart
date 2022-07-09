import 'dart:convert';

import 'package:flutter_application/repository/local_storage_repository.dart';

class ContentsRepository extends LocalStorageRepository {
  final String MY_FAVORITE_KEY = "MY_FAVORITE_KEY";

  Future<List?> loadFavoriteContents() async {
    String? jsonString = await this.getValue(MY_FAVORITE_KEY);
    if (jsonString != null) {
      List<dynamic> json = jsonDecode(jsonString);
      return json;
    } else {
      return null;
    }
  }

  addMyFavoriteContent(dynamic id) async {
    List? favoriteContentList = await loadFavoriteContents();
    if (favoriteContentList == null || !(favoriteContentList is List)) {
      favoriteContentList = [id];
    } else {
      favoriteContentList.add(id);
    }
    updateFavoriteContent(favoriteContentList); //저장
  }

  isMyFavoriteContents(dynamic id) async {
    bool isMyFavoriteContents = false;
    List? json = await loadFavoriteContents();
    if (json == null || !(json is List)) {
      return false;
    } else {
      for (dynamic data in json) {
        if (data == id) {
          isMyFavoriteContents = true;
          break;
        }
      }
      return isMyFavoriteContents;
    }
  }

  deleteMyFavoriteContent(id) async {
    List? favoriteContentList = await loadFavoriteContents();
    if (favoriteContentList != null && favoriteContentList is List) {
      favoriteContentList.removeWhere((data) => data == id);
    }

    updateFavoriteContent(favoriteContentList);
  }

  void updateFavoriteContent(List? favoriteContentList) async {
    await this.setValue(MY_FAVORITE_KEY, jsonEncode(favoriteContentList));
  }
}
