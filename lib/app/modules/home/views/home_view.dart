import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7E7E7),
        toolbarHeight: 60.0,
        title: Container(
          width: width,
          decoration: BoxDecoration(
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
                icon: Icon(
                  Icons.notifications_active,
                  size: 40,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
