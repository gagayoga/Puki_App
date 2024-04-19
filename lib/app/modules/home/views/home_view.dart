import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60.0,
        title: Container(
          width: width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/splash/fotoprofile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Flexible(
                flex: 1,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/splash/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              IconButton(
                onPressed: () {
                  // Tindakan yang diambil saat tombol di tekan
                },
                icon: const Icon(
                  Icons.notifications_active,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
      ),
      body: Container(
        color: const Color(0xFFE7E7E7),
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                height: height * 0.020,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SvgPicture.asset(
                  'assets/images/slider/slider1.svg',
                  fit: BoxFit.fitWidth,
                ),
              ),

              SizedBox(
                height: height * 0.015,
              ),

              kontenBukuPopular(),

              kontenBukuTerbaru(),
            ],
          ),
        ),
      )
    );
  }

  Widget kontenBukuPopular(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Buku TerPopular",
            maxLines: 1,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF383838),
              fontSize: 24.0,
            ),
          ),
        ),

        const SizedBox(
          height: 15,
        ),

        Obx((){
            if (controller.popularBooks.isNull) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF383838)),
                ),
              );
            } else if (controller.popularBooks.value == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF383838)),
                ),
              );
            } else {
              return Container(
                color: const Color(0xFF3E3E3E),
                height: 220,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: 120,
                            height: 205,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/konten/buku_popular.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.popularBooks.value!.length,
                          itemBuilder: (context, index) {
                            var buku = controller.popularBooks.value![index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.DETAILBUKU,
                                  parameters: {
                                    'id': (buku.bukuID ?? 0).toString(),
                                    'judul': (buku.judul!).toString(),
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          height: 180,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: AspectRatio(
                                              aspectRatio: 4 / 5,
                                              child: Image.network(
                                                buku.coverBuku.toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Container(
                                              width: 225,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF383838).withOpacity(0.9),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Buku Popular',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ), // Jika status null atau tidak popular, maka widget ini tidak akan ditampilkan
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {

                            },
                            child: Container(
                              width: 120,
                              height: 205,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFE7E7E7).withOpacity(0.60),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: const Color(0xFF383838),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Lihat Semuanya",
                                    style: GoogleFonts.lato(
                                      color: const Color(0xFF383838),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget kontenBukuTerbaru() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Buku Terbaru",
            maxLines: 1,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF383838),
              fontSize: 24.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx((){
              if (controller.newBooks.isNull) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF383838)),
                  ),
                );
              } else if (controller.newBooks.value == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF383838)),
                  ),
                );
              } else {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 3 / 5,
                  ),
                  itemCount: controller.newBooks.value!.length,
                  itemBuilder: (context, index) {
                    var buku = controller.newBooks.value![index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.DETAILBUKU,
                          parameters: {
                            'id': (buku.bukuID ?? 0).toString(),
                            'judul': (buku.judulBuku!).toString(),
                          },
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                buku.coverBuku.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
