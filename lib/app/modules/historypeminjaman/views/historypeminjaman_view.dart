import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/historypeminjaman_controller.dart';

class HistorypeminjamanView extends GetView<HistorypeminjamanController> {
  const HistorypeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Color
    const Color background = Color (0xFFE7E7E7);

    // Count data koleksi buku
    var count = controller.jumlahHistoryPeminjaman;

    // Size
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bodyHeight = height - 55;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        toolbarHeight: 55,
        title: InkWell(
          onTap: (){
            controller.getDataHistory();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'History Peminjaman',
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
                child: kontenHistoryPeminjaman(),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget kontenHistoryPeminjaman() {
    const Color background = Color(0xFF383838);
    const Color borderColor = Color(0xFF424242);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Buku yang dipinjam",
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
              if (controller.historyPeminjaman.isEmpty) {
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
                        'Belum ada history peminjaman buku yang tersimpan',
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
                      controller.historyPeminjaman.length,
                          (index) {
                        var buku = controller.historyPeminjaman[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: (){
                              buku.status == 'Selesai' ? controller.kontenBeriUlasan(buku.bukuId.toString(), buku.judulBuku.toString()) :
                              Get.toNamed(Routes.DETAILPEMINJAMAN, parameters: {
                                'idPeminjaman': buku.peminjamanID.toString(),
                                'asalHalaman' : 'historyPeminjaman',
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(Get.context!).size.width,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              height: 200,
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Flexible(
                                    flex:2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        height: 200,
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
                                                aspectRatio: 4 / 6,
                                                child: Image.network(
                                                  buku.coverBuku.toString(),
                                                  fit: BoxFit.cover,
                                                  width: 125,
                                                ),
                                              ),
                                            ),
                            
                                            Positioned(
                                              left: 0,
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: buku.status == 'Ditolak'
                                                        ? const Color(0xFFEA1818)
                                                        : buku.status == 'Dipinjam'
                                                        ? const Color(0xFFFBC446)
                                                        : buku.status ==
                                                        'Selesai'
                                                        ? const Color(0xFF005D14)
                                                        : const Color(0xFF1B1B1D),
                                                    borderRadius: const BorderRadius.only(
                                                      bottomLeft: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                    )),
                                                child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 10, horizontal: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        const FaIcon(
                                                          FontAwesomeIcons.circleInfo,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          buku.status!.toString(),
                                                          style: GoogleFonts.inriaSans(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
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
                                            'No : ${buku.kodePeminjaman!}',
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w900,
                                              color: const Color(0xFF260534),
                                              fontSize: 24.0,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            buku.judulBuku!,
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w900,
                                              color: const Color(0xFF260534),
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                            
                                          const SizedBox(
                                            height: 10,
                                          ),
                            
                                          Text(
                                            'Tanggal Pinjam : ${buku.tanggalPinjam!}',
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                            
                                          Text(
                                            'Deadline : ${buku.deadline!}',
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                            
                                          Text(
                                            'Tanggal Kembali : ${buku.tanggalKembali!}',
                                            style: GoogleFonts.lato(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
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
