import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // untuk berpindah halaman otomatis setelah 4 detik
    Future.delayed(
        const Duration(milliseconds: 5000), ( (){
      Get.offAllNamed(Routes.ONBOARDING);
    })
    );
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
