import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/buku/response_search_buku.dart';
import '../../../routes/app_pages.dart';
import '../controllers/buku_controller.dart';

class BukuView extends GetView<BukuController> {
  const BukuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Font Size
    double textField = 18.0;

    //const Color background = Colors.white;
    const Color backgroundLogin = Color(0xFFFFC533);
    const Color backgroundHome = Color(0xFFE7E7E7);
    const Color colorButton = Color(0xFF383838);
    return Scaffold(
      // Appbar
      appBar: AppBar(
        toolbarHeight: 80,
        title: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: controller.searchController,
            style: GoogleFonts.lato(
                fontSize: textField,
                fontWeight: FontWeight.w600,
                color: Colors.black),
            onChanged: (value){
              controller.getDataSearchBook();
            },
            decoration: InputDecoration(
              filled: true,
              prefixIcon: const Icon(Icons.search_rounded),
              prefixIconColor: colorButton,
              fillColor: Colors.white,
              hintText: "Pencarian Buku",
              hintStyle: GoogleFonts.lato(
                  fontSize: textField,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder:  OutlineInputBorder(
                borderSide: const BorderSide(color: colorButton, width: 1.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder:  OutlineInputBorder(
                borderSide: const BorderSide(color: backgroundLogin, width: 1.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              return null;
            },
          ),
        ),
      ),

      body: Container(
        color: backgroundHome,
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                height: height * 0.001,
              ),

              Image.asset(
                'assets/images/konten/konten_buku.png',
                fit: BoxFit.cover,
              ),

              SizedBox(
                height: height * 0.020,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: kontenDataBuku(),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget kontenDataBuku(){
    const Color background = Color(0xFF383838);
    const Color borderColor = Color(0xFF424242);

    return Obx((){
      if (controller.searchBook.isEmpty) {
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
                'Belum ada data buku',
                style: GoogleFonts.inriaSans(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }else{
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.searchBook.length,
          itemBuilder: (context, index){
            var kategori = controller.searchBook[index].kategoriBuku;
            var bukuList = controller.searchBook[index].dataBuku;
            if (bukuList == null || bukuList.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      kategori!,
                      style: GoogleFonts.lato(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                          'Belum ada buku dalam kategori ini',
                          style: GoogleFonts.inriaSans(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      kategori!,
                      style: GoogleFonts.lato(
                          fontSize: 18.0,
                          color: borderColor,
                          fontWeight: FontWeight.w700
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SizedBox(
                    height: 185,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bukuList.length,
                      itemBuilder: (context, index) {
                        DataBuku buku = bukuList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: InkWell(
                            onTap: (){
                              Get.toNamed(
                                Routes.DETAILBUKU,
                                parameters: {
                                  'id': (buku.bukuID ?? 0).toString(),
                                  'judul': (buku.judul).toString(),
                                },
                              );
                            },
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: 135,
                                  height: 185,
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
                                  child: buku.status == null && buku.status == "Popular" ? ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Container(
                                      width: 135,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: borderColor.withOpacity(0.9),
                                      ),
                                      child: SizedBox(
                                        child: Text(
                                          buku.status!,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inriaSans(
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
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  Widget sectionDataKosong(String text) {
    const Color background = Color(0xFF383838);
    const Color borderColor = Color(0xFF424242);
    return Center(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: 1.3,
            )),
        child: Center(
          child: Text(
            'Sorry Data $text Empty!',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
