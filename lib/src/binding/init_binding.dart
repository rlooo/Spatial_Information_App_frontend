import 'package:flutter_application/src/controller/favorite_controller.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteController(), permanent: true);
  }
}
