import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {

  final loadinglogin = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  registerPost() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        var response = await ApiProvider.instance().post(Endpoint.register,
            data:
            {
              "username": usernameController.text.toString(),
              "email": emailController.text.toString(),
              "password": passwordController.text.toString()
            }
        );
        if (response.statusCode == 201) {
          String username = usernameController.text.toString();
          _showMyDialog(
                  (){
                Get.to( Get.offAllNamed(Routes.LOGIN), transition: Transition.cupertinoDialog);
              },
              "Registrasi Berhasil",
              "Selamat Datang $username, Silakan Login Dulu",
              "Lanjut");
        } else {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "Login Gagal, Coba kembali masuk dengan akun anda",
              "Ok"
          );
        }
      }
      loadinglogin(false);
    } on DioException catch (e) {
      loadinglogin(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          _showMyDialog(
                  (){
                Navigator.pop(Get.context!, 'OK');
              },
              "Pemberitahuan",
              "${e.response?.data?['message']}",
              "Ok"
          );
        }
      } else {
        _showMyDialog(
              (){
            Navigator.pop(Get.context!, 'OK');
          },
          "Pemberitahuan",
          e.message ?? "",
          "OK",
        );
      }
    } catch (e) {
      loadinglogin(false);
      _showMyDialog(
            (){
          Navigator.pop(Get.context!, 'OK');
        },
        "Error",
        e.toString(),
        "OK",
      );
    }
  }

  Future<void> _showMyDialog(final onPressed, String judul, String deskripsi, String nameButton) async {
    return showCupertinoDialog(
        context: Get.context!,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
              title: Text(
                judul,
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700
                ),
              ),
              content: Text(
                deskripsi,
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500
                ),
              ),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  onPressed: onPressed,
                  child: Text(
                    nameButton,
                    style: GoogleFonts.inter(
                        color: const Color(0xFF260534),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                )
              ],
            )
    );
  }
}
