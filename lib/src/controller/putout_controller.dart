import 'dart:html';

import 'package:flutter_application/data/putOutBoard.dart';
import 'package:flutter_application/src/controller/favorite_controller.dart';
import 'package:get/get.dart';

class PutOutController extends GetxController {
  static PutOutController get to => Get.find();
  var putoutList = <PutOutBoard>[].obs;
  var list = <PutOutBoard>[];
  @override
  void onInit() {
    super.onInit();
  }

  void updateFavoritePutOutData() {
    putoutList.clear();
  }

  void updateFavoritePutOut(PutOutBoard putout) {
    FavoriteController.to.updateFavorite(putout);
    updateFavoritePutOutData();
  }
}
