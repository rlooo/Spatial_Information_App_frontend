import 'package:flutter_application/src/controller/favorite_controller.dart';
import 'package:flutter_application/src/controller/token_controller.dart';
import 'package:flutter_application/src/controller/user_controller.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(FavoriteController(), permanent: true);
    Get.put(TokenController(), permanent: true);
    Get.put(UserController(), permanent: true);
  }
}
