import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:thoriq_puki/app/modules/buku/views/buku_view.dart';
import 'package:thoriq_puki/app/modules/historypeminjaman/views/historypeminjaman_view.dart';

import '../../../components/customBarMaterial.dart';
import '../../bookmark/views/bookmark_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(

              body: SafeArea(
                child: SafeArea(
                  child: Center(
                      child: IndexedStack(
                        index: controller.tabIndex,
                        children: const [
                          HomeView(),
                          BukuView(),
                          BookmarkView(),
                          HistorypeminjamanView(),
                        ],
                      )
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                color: const Color(0xFF383838),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomBottomBarMaterial(
                    onTap: controller.changeTabIndex,
                    currentIndex: controller.tabIndex,
                  ),
                ),
              )
          );
        }
    );
  }
}
