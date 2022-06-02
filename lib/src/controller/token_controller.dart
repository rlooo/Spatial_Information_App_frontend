import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class TokenController extends GetxService {
  static TokenController get to => Get.find();
  RxBool token = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    token.value = false;
    super.onClose();
  }

  void updateToken(bool state) {
    if (state == true) {
      token = true.obs;
    } else {
      token = false.obs;
    }
  }
}
