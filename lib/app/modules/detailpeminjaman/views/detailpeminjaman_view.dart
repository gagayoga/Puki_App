import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/detailpeminjaman_controller.dart';

class DetailpeminjamanView extends GetView<DetailpeminjamanController> {
  const DetailpeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Stack(
            children: [

              Container(
                width: width,
                height: height * 0.35,
                decoration: const BoxDecoration(
                  color: Color(0xFF383838),
                ),
              ),

              Positioned.fill(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20,),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80, bottom: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          kontenData(width, height),

                          Align(
                            alignment: Alignment.topCenter,
                            child: FractionalTranslation(
                              translation: const Offset(0.01, -0.50),
                              child: SizedBox(
                                width: 65,
                                height: 65,
                                child: Image.asset(
                                  'assets/images/icon_check.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget kontenData(double width, double height){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Obx((){
          String asalHalaman = Get.parameters['asalHalaman'].toString();

          if (controller.detailPeminjaman.value == null){
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFC533)),
                ),
              ),
            );
          }else{
            var dataPeminjaman = controller.detailPeminjaman.value;

            return SingleChildScrollView(
              child: Column(
                children: [

                  const SizedBox(
                    height: 10,
                  ),

                  FittedBox(
                    child: Text(
                      'Peminjaman Buku Berhasil',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 26.0
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.010,
                  ),

                  Divider(
                    color: Colors.black.withOpacity(0.10),
                    thickness: 1,
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  Container(
                    color: const Color(0xFF383838),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: FittedBox(
                        child: Text(
                          dataPeminjaman!.kodePeminjaman.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFFFC533),
                              fontSize: 36.0
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  kontenBuktiPeminjaman(
                      'Tanggal Peminjaman', dataPeminjaman.tanggalPinjam.toString()
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  kontenBuktiPeminjaman(
                      'Deadline Peminjaman', dataPeminjaman.deadline.toString()
                  ),

                  SizedBox(
                    height: height * 0.040,
                  ),

                  Divider(
                    color: Colors.black.withOpacity(0.10),
                    thickness: 1,
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  kontenBuktiPeminjaman(
                      'Nama Peminjam', dataPeminjaman.username.toString()
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  kontenBuktiPeminjaman(
                      'Nama Buku', dataPeminjaman.judulBuku.toString()
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  kontenBuktiPeminjaman(
                      'Penulis Buku', dataPeminjaman.penulisBuku.toString()
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  kontenBuktiPeminjaman(
                      'Tahun Terbit', dataPeminjaman.tahunBuku.toString()
                  ),

                  SizedBox(
                    height: height * 0.040,
                  ),

                  Container(
                    color: const Color(0xFF383838),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              'Note:',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFFFC533),
                                  fontSize: 24.0
                              ),
                            ),
                          ),

                          SizedBox(
                            height: height * 0.005,
                          ),

                          FittedBox(
                            child: Text(
                              'Harap kembalikan buku tepat waktu. Terima kasih.',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFFFC533),
                                  fontSize: 14.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  kontenButton(
                          (){

                      },
                      Text(
                        'Screenshot Bukti Peminjaman',
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      100.0,
                      const Color(0xFF383838)
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  kontenButton(
                          (){
                        String asalHalaman = Get.parameters['asalHalaman'].toString();
                        if (asalHalaman == 'detailBuku') {
                          Get.offAllNamed(Routes.DASHBOARD); // Navigasi ke halaman detail buku
                        } else if (asalHalaman == 'historyPeminjaman') {
                          Get.back();
                        }
                      },
                      Text(
                        asalHalaman == 'detailBuku' ? 'Kembali ke Beranda' : 'Kembali',
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                      100.0,
                      const Color(0xFFFFC533)
                  ),
                ],
              ),
            );
          }
        })
    );
  }

  Widget kontenBuktiPeminjaman(String judul, String isi){
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              judul,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16.0
              ),
            ),
          ),

          Flexible(
            flex: 3,
            child: Text(
              isi,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                  fontSize: 16.0
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget kontenButton(final onPressed,final Widget child,
      final double radius,
      final Color buttonColor,){
    const Color borderColor = Color(0xFF424242);
    return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)
            ),
            side: const BorderSide(
              color: borderColor, // Warna border (stroke)
              width: 0.03, // Lebar border (stroke)
            ),
          ),
          onPressed: onPressed,
          child: child,
        )
    );
  }
}
