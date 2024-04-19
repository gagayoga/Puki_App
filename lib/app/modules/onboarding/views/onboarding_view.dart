import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:thoriq_puki/app/routes/app_pages.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double h1 = 30.0;
    double h2 = 24.0;
    double h3 = 20.0;
    double paragraf = 16.0;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    const Color background = Color(0xFF393838);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: background,
      statusBarIconBrightness: Brightness.light,// Change this color as needed
    ));

    return Scaffold(

        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // memberikan latar belakang
            decoration: const BoxDecoration(
              color: Color(0xFF393838),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width,
                  margin: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(
                          padding: EdgeInsets.only(bottom: height * 0.02),
                          child: SizedBox(
                            width: width * 0.8,
                            child: Text('Memudahkan pinjam buku di perpustakaan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: h1,
                                letterSpacing: -0.1,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: width * 0.8,
                          child: Text('Sekarang kamu meminjam buku cukup menggunakan smartphone',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: h2,
                              letterSpacing: -0.8,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Lottie.asset(
                  'assets/images/splash/logo_puki.json',
                  repeat: false,
                ),

                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 75.0,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: (){
                                  Get.toNamed(Routes.REGISTER);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20)
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Daftar',
                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: h2
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        width: 5,
                      ),

                      Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 75.0,
                              child: ElevatedButton(
                                onPressed: (){
                                  Get.toNamed(Routes.LOGIN);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20)
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Masuk',
                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: h2
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
