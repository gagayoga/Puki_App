import 'package:get/get.dart';

import '../controllers/buku_controller.dart';

class BukuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BukuController>(
      () => BukuController(),
    );
  }
}
