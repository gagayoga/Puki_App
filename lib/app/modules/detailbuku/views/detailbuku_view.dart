import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/buku/response_detail_buku.dart';
import '../controllers/detailbuku_controller.dart';

class DetailbukuView extends GetView<DetailbukuController> {
  const DetailbukuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Color
    const Color background = Color (0xFFE7E7E7);

    // Size
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bodyHeight = height - 55;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: background,
        toolbarHeight: 55,
        title: Text(
          'Detail Buku ${Get.parameters['judul'].toString()}',
          style: GoogleFonts.lato(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Container(
        width: width,
        height: bodyHeight,
        color: background,
        child: Stack(
          children: [

            // Detail Buku
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 95), // Sesuaikan dengan tinggi tombol
                child: kontenDataDetailBuku(),
              ),
            ),

            // Floating Button
            floatingButton(),

            // Button Pinjam
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: width,
                  height: 90,
                  decoration: BoxDecoration(
                    color: background,
                    border: Border(
                      top: BorderSide(
                        color: const Color(0xFF424242).withOpacity(0.50),
                        width: 0.2,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: buttonDetailBuku(),
                  ),
                )
            )
          ],
        ),
      )
    );
  }

  Widget kontenDataDetailBuku() {
    final height = MediaQuery.of(Get.context!).size.height;

    // Color
    const Color backgroundLogin = Color(0xFFFFC533);
    const Color colorButton = Color(0xFF383838);
    const Color colorText = Color(0xFF000000);
    const Color colorActive = Color(0xFF08C8F6);

    return Obx((){
        if (controller.detailBuku.isNull) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(backgroundLogin),
              ),
            ),
          );
        } else if (controller.detailBuku.value == null) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(backgroundLogin),
              ),
            ),
          );
        } else {
          var dataBuku = controller.detailBuku.value!.buku;
          var dataKategori = controller.detailBuku.value!.kategori;
          var dataUlasan = controller.detailBuku.value!.ulasan;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.050,
                ),

                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 225,
                        height: 300,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: const Offset(0, 8), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            dataBuku!.coverBuku!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Positioned(
                        top: 0,
                        left: 0,
                        child: dataBuku.jenisBuku != null && dataBuku.jenisBuku == "Popular" ? ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Container(
                            width: 225,
                            height: 40,
                            decoration: BoxDecoration(
                              color: colorButton.withOpacity(0.9),
                            ),
                            child: Center(
                              child: Text(
                                'Buku ${dataBuku.jenisBuku!}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ) : const SizedBox(), // Jika status null atau tidak popular, maka widget ini tidak akan ditampilkan
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: height * 0.030,
                ),

                FittedBox(
                  child: Text(
                    dataBuku.judul!,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w900,
                      color: colorText,
                      fontSize: 26.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                FittedBox(
                  child: Text(
                    "${dataBuku.jumlahHalaman!} Halaman",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w900,
                      color: colorText,
                      fontSize: 20.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(
                  height: height * 0.005,
                ),

                FittedBox(
                  child: Text(
                    "Penulis: ${dataBuku.penulis!}",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600,
                      color: colorText,
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),


                SizedBox(
                  height: height * 0.010,
                ),

                // Menampilkan rating di bawah teks penulis
                RatingBarIndicator(
                  rating: dataBuku.rating!,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 24,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: colorActive,
                  ),
                ),

                SizedBox(
                  height: height * 0.030,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Buku",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w800,
                        color: colorText,
                        fontSize: 20.0,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    Divider(
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.20),
                    ),

                    SizedBox(
                      height: height * 0.010,
                    ),

                    FittedBox(
                      child: Text(
                        "Jumlah Peminjam : ${dataBuku.jumlahPeminjam!} Peminjam",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w700,
                          color: colorText,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.010,
                    ),

                    FittedBox(
                      child: Text(
                        "Penerbit: ${dataBuku.penerbit!}",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w700,
                          color: colorText,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.010,
                    ),

                    FittedBox(
                      child: Text(
                        "Jenis Buku: ${dataBuku.jenisBuku!}",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w700,
                          color: colorText,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.010,
                    ),

                    Text(
                      "Deskripsi Buku:",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w700,
                        color: colorText,
                        fontSize: 16.0,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.005,
                    ),

                    Text(
                      dataBuku.deskripsi!,
                      maxLines: 15,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        color: colorText.withOpacity(0.80),
                        fontSize: 14.0,
                        height: 1.9,
                      ),
                      textAlign: TextAlign.justify,
                    ),

                    SizedBox(
                      height: height * 0.015,
                    ),


                    Wrap(
                      children: dataKategori!.map((kategori) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextButton(
                            onPressed: () {
                              // Tambahkan fungsi yang ingin dijalankan saat tombol ditekan
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFF5F5F5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Text(
                              kategori,
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w700,
                                color: Colors.black, // Sesuaikan dengan warna yang diinginkan
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(
                      height: height * 0.025,
                    ),

                    Text(
                      "Ulasan Buku",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w700,
                        color: colorText,
                        fontSize: 20.0,
                      ),
                    ),

                    Divider(
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.20),
                    ),

                    SizedBox(
                      height: height * 0.010,
                    ),

                    buildUlasanList(dataUlasan),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ulasanList.length,
      itemBuilder: (context, index) {
        Ulasan ulasan = ulasanList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA).withOpacity(0.30),
                borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          'assets/images/splash/fotoprofile.png',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.035,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ulasan.users?.username ?? '',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 10),
                        ),

                        Text(
                          ulasan.ulasan ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 14.0),
                        ),

                        // Menampilkan rating di bawah teks penulis
                        RatingBarIndicator(
                          direction: Axis.horizontal,
                          rating: ulasan.rating!.toDouble(),
                          itemCount: 5,
                          itemSize: 10,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color(0xFF08C8F6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        : Container(
      width: width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF383838),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF424242),
          width: 0.5,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }

  Widget buttonDetailBuku() {
    const Color buttonColor = Color(0xFF383838);

    return Obx((){
      var dataBuku = controller.detailBuku.value?.buku;
      return SizedBox(
        width: double.infinity,
        height: 40.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: dataBuku?.statusPeminjaman == 'Belum dipinjam' ? buttonColor : const Color(0xFFFC5330),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (dataBuku?.statusPeminjaman == 'Belum dipinjam') {
              controller.showConfirmPeminjaman(() => Navigator.pop(Get.context!, 'OK'), 'Lanjutkan');
            }else if(dataBuku?.statusPeminjaman == 'Dipinjam'){
              return;
            }
          },
          child: Text(
            dataBuku?.statusPeminjaman == 'Belum dipinjam'
                ? 'Pinjam Buku' : 'Dipinjam',
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }

  Widget floatingButton(){
    const Color colorActive = Color(0xFF08C8F6);

    return GetBuilder<DetailbukuController>(
        builder: (controller) {
          var dataBuku = controller.detailBuku.value?.buku;
          return Positioned(
            bottom: 100,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
                if (dataBuku?.status == "Tersimpan") {
                  return;
                } else {
                  controller.addKoleksiBuku();
                }
              },
              backgroundColor: dataBuku?.status == "Tersimpan"
                  ? Colors.white
                  : colorActive,
              child: FaIcon(
                dataBuku?.status == "Tersimpan"
                    ? CupertinoIcons.bookmark_fill
                    : Icons.bookmark_add_rounded,
                color: dataBuku?.status == "Tersimpan" ? colorActive : Colors
                    .white,
                size: 28,
              ),
            ),
          );
        }
    );
  }
}
