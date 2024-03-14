import 'package:get/get.dart';
import 'package:thoriq_puki/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:thoriq_puki/app/modules/home/controllers/home_controller.dart';
import 'package:thoriq_puki/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<BookmarkController>(
          () => BookmarkController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );

  }
}
