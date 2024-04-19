import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    String? status = StorageProvider.read(StorageKey.status);

    // untuk berpindah halaman otomatis setelah 4 detik
    Future.delayed(const Duration(milliseconds: 5000), ( (){
      if (status == "logged") {
        Get.offAllNamed(Routes.DASHBOARD);
      }else{
        Get.offAllNamed(Routes.ONBOARDING);
      }})
    );

    const Color background = Color(0xFF393838);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: background,
      statusBarIconBrightness: Brightness.light,// Change this color as needed
    ));
    return Scaffold(
        body: SafeArea(
          child: Container(
            // memberikan background color
            decoration: const BoxDecoration(
              color: Color(0xFF393838),
            ),
            child: Center(
              //  gambar logo splash screen
              child: Lottie.asset(
                'assets/images/splash/logo_puki.json',
                repeat: false,
              ),
            ),
          ),
        )
    );
  }
}
