import 'package:flutter_application/repository/local_storage_repository.dart';

class ContentsRepository extends LocalStorageRepository {
  final String MY_FAVORITE_KEY = "MY_FAVORITE_KEY";

  addMyFavoriteContent(dynamic id) {
    this.setValue(MY_FAVORITE_KEY, id); //저장
  }

  isMyFavoriteContents(dynamic id) async {
    String? stringVal = await this.getValue(MY_FAVORITE_KEY);
    if (stringVal != null) {
      return id.toString() == stringVal;
    } else {
      return null;
    }
  }

  deleteMyFavoriteContent(id) {}
}
