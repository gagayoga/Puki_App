import 'package:get/get.dart';

import '../controllers/detailpeminjaman_controller.dart';

class DetailpeminjamanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailpeminjamanController>(
      () => DetailpeminjamanController(),
    );
  }
}
