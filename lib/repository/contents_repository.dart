import 'dart:convert';

import 'package:flutter_application/repository/local_storage_repository.dart';

class ContentsRepository extends LocalStorageRepository {
  final String MY_FAVORITE_KEY = "MY_FAVORITE_KEY";

  Future<List?> loadFavoriteContents() async {
    String? jsonString = await this.getValue(MY_FAVORITE_KEY);
    if (jsonString != null) {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return json["favorites"];
    } else {
      return null;
    }
  }

  addMyFavoriteContent(Map<String, dynamic> putout) async {
    List? loadLocalStorageDatas = await loadFavoriteContents();
    if (loadLocalStorageDatas == null) {
      loadLocalStorageDatas = [putout];
    } else {
      loadLocalStorageDatas.add(putout);
      print(loadLocalStorageDatas);
    }
    updateFavoriteContent(loadLocalStorageDatas); //저장
  }

  isMyFavoriteContents(dynamic id) async {
    bool isMyFavoriteContents = false;
    List? json = await loadFavoriteContents();
    if (json == null || !(json is List)) {
      return false;
    } else {
      for (dynamic data in json) {
        if (data["id"] == id) {
          isMyFavoriteContents = true;
          break;
        }
      }
      return isMyFavoriteContents;
    }
  }

  Future<void> deleteMyFavoriteContent(dynamic id) async {
    List? loadLocalStorageDatas = await loadFavoriteContents();
    if (loadLocalStorageDatas != null) {
      loadLocalStorageDatas.removeWhere((element) => element["id"] == id);
      print(loadLocalStorageDatas);
    }

    updateFavoriteContent(loadLocalStorageDatas ?? []);
  }

  void updateFavoriteContent(List loadLocalStorageDatas) async {
    Map<String, dynamic> myFavoriteDatas = {"favorites": loadLocalStorageDatas};
    await this.setValue(MY_FAVORITE_KEY, jsonEncode(myFavoriteDatas));
  }
}
