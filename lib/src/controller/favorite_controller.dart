// import 'package:flutter_application/data/putOutBoard.dart';
// import 'package:get/get.dart';

// class FavoriteController extends GetxController {
//   static FavoriteController get to => Get.find();
//   var favoriteList = <PutOutBoard>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//   }

//   void updateFavorite(PutOutBoard putout) {
//     if (favoriteList.contains(putout)) {
//       putout.setFavorite(false);
//       favoriteList.remove(putout);
//       print(favoriteList);
//     } else {
//       putout.setFavorite(true);
//       favoriteList.add(putout);
//       print(favoriteList);
//     }
//     //db.update
//   }
// }
