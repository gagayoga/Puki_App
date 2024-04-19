import 'package:get/get.dart';

import '../controllers/detailbuku_controller.dart';

class DetailbukuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailbukuController>(
      () => DetailbukuController(),
    );
  }
}
