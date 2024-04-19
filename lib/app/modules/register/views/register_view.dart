import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Font Size
    double h1 = 35.0;
    double text1 = 16.0;
    double textField = 18.0;
    double h2 = 24.0;

    //const Color background = Colors.white;
    const Color backgroundLogin = Color(0xFFFFC533);
    const Color colorButton = Color(0xFF383838);
    const Color colorText = Color(0xFF000000);
    const Color colorActive = Color(0xFF08C8F6);


    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: height * 0.25,
                      child: SvgPicture.asset('assets/images/logo/logo_puki.svg')
                  ),
                ),

                Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Daftar',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.lato(
                                fontSize: h1,
                                fontWeight: FontWeight.w800,
                                color: colorText
                            ),
                          ),
                        ),

                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              TextFormField(
                                controller: controller.usernameController,
                                style: GoogleFonts.lato(
                                    fontSize: textField,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Username",
                                  labelStyle: GoogleFonts.lato(
                                      fontSize: textField,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  hintText: "ThoriqFahma",
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
                                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                ),
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'Username tidak boleh kosong';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(
                                height: height * 0.025,
                              ),

                              TextFormField(
                                controller: controller.emailController,
                                style: GoogleFonts.lato(
                                    fontSize: textField,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Email Address",
                                  labelStyle: GoogleFonts.lato(
                                      fontSize: textField,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                  hintText: "thoriq.fahma34@smk.belajar.id",
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
                                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                ),
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'Email tidak boleh kosong!';
                                  }else if (!EmailValidator.validate(value)) {
                                    return 'Email address tidak sesuai';
                                  }else if (!value.endsWith('@smk.belajar.id')){
                                    return 'Email harus @smk.belajar.id';
                                  }
                                  return null;
                                },
                              ),

                              SizedBox(
                                height: height * 0.025,
                              ),

                              Obx(() =>
                                  TextFormField(
                                    obscureText: controller.isPasswordHidden.value,
                                    controller: controller.passwordController,
                                    style: GoogleFonts.lato(
                                        fontSize: textField,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      suffixIcon: InkWell(
                                        child: Icon(
                                          controller.isPasswordHidden.value
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        onTap: (){
                                          controller.isPasswordHidden.value =! controller.isPasswordHidden.value;
                                        },
                                      ),
                                      fillColor: Colors.white,
                                      labelText: "Password",
                                      labelStyle: GoogleFonts.lato(
                                          fontSize: textField,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      hintText: "Password",
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
                                      const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Password tidak boleh kosong';
                                      } else if (value.length < 8){
                                        return 'Panjang password harus lebih dari 8';
                                      }
                                      // Validasi setidaknya satu huruf besar
                                      else if (!value.contains(RegExp(r'[A-Z]'))) {
                                        return 'Password harus mengandung satu huruf besar';
                                      }
                                      // Validasi setidaknya satu karakter khusus
                                      else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                        return 'Password harus mengandung satu karakter khusus';
                                      }
                                      // Validasi setidaknya satu angka
                                      else if (!value.contains(RegExp(r'[0-9]'))) {
                                        return 'Password harus mengandung minimal 1 angka';
                                      }
                                      return null;
                                    },
                                  ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: SizedBox(
                                    height: 55.0,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () => controller.registerPost(),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: colorButton,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(15),
                                                topLeft: Radius.circular(15)
                                            ),
                                          ),
                                        ),
                                        child: Obx(
                                              () => controller.loadinglogin.value
                                              ? const CircularProgressIndicator(
                                            color: backgroundLogin,
                                          )
                                              : Text(
                                          'Daftar',
                                          style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: h2
                                          ),
                                        ),
                                      ),
                                    )),
                              ),

                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sudah punya akun?',
                                      style: GoogleFonts.lato(
                                          fontSize: text1,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Get.offAllNamed(Routes.LOGIN);
                                      },
                                      child: Text('Masuk',
                                          style: GoogleFonts.lato(
                                            fontSize: text1,
                                            fontWeight: FontWeight.w700,
                                            color: colorActive,
                                          )),
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

              ],
            ),
          ),
        )
    );
  }
}
