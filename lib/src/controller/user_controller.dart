import 'package:get/get.dart';

class UserController extends GetxService {
  static UserController get to => Get.find();
  RxString uid = ''.obs;
  RxString? email = ''.obs;
  RxString? nickname = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void updateUserInfo(String _uid, String? _nickname, String? _email) {
    uid = _uid.obs;
    nickname = _nickname?.obs;
    email = _email?.obs;
  }
}
