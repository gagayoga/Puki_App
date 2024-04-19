import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Color
    const Color background = Color (0xFFE7E7E7);

    // Count data koleksi buku
    var count = controller.jumlahKoleksiBook;

    // Size
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bodyHeight = height - 55;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        toolbarHeight: 55,
        title: RefreshIndicator(
          onRefresh: () async{
            await controller.getData();
          },
          child: InkWell(
            onTap: () async{
              await controller.getData();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Koleksi Buku',
                  style: GoogleFonts.lato(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                count > 0
                    ? Container(
                  margin: const EdgeInsetsDirectional.only(start: 5),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                      color: Color(0xFF08C8F6),
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Text(
                      count > 20 ? "20++" : count.toString(),
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ) : const SizedBox(width: 0, height: 0,),
              ],
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),

      body: SizedBox(
        width: width,
        height: bodyHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.020,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: kontenKoleksiBuku(),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget kontenKoleksiBuku() {
    const Color background = Color(0xFF383838);
    const Color borderColor = Color(0xFF424242);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Buku yang disimpan",
          maxLines: 1,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w800,
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          child: Obx((){
              if (controller.koleksiBook.isEmpty) {
                return Center(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: borderColor,
                          width: 1.3,
                        )
                    ),
                    child: Center(
                      child: Text(
                        'Belum ada koleksi buku yang tersimpan',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: List.generate(
                      controller.koleksiBook.length,
                          (index) {
                        var buku = controller.koleksiBook[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(
                                Routes.DETAILBUKU,
                                parameters: {
                                  'id': (buku.bukuID ?? 0).toString(),
                                  'judul': (buku.judul!).toString(),
                                },
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(Get.context!).size.width,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              height: 150,
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Gambar di sebelah kiri
                                  Flexible(
                                    flex:2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 150,
                                        decoration : BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: const Offset(0, 5), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        // Lebar gambar 40% dari layar
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: AspectRatio(
                                                aspectRatio: 4 / 4,
                                                child: Image.network(
                                                  buku.coverBuku.toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              left: 0,
                                              child: buku.jenisBuku != null && buku.jenisBuku == "Popular" ? ClipRRect(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                                child: Container(
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: borderColor.withOpacity(0.9),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Buku ${buku.jenisBuku!}',
                                                      textAlign: TextAlign.center,
                                                      style: GoogleFonts.inriaSans(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ) : const SizedBox(), // Jika status null atau tidak popular, maka widget ini tidak akan ditampilkan
                                            ),

                                            Positioned(
                                              right: 5,
                                              bottom: 10,
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF08C8F6),
                                                    borderRadius: BorderRadius.circular(50)
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      CupertinoIcons.bookmark_fill,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),


                                  Flexible(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            buku.judul!,
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w900,
                                              color: const Color(0xFF260534),
                                              fontSize: 20.0,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),

                                          const SizedBox(
                                            height: 3,
                                          ),

                                          Text(
                                            buku.deskripsi!,
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 12.0,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),

                                          const SizedBox(
                                            height: 3,
                                          ),

                                          Text(
                                            "Penulis : ${buku.penulis!}",
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 12.0,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
