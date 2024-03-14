import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
                        children: [
                          HomeView(),
                          BookmarkView(),
                          HomeView(),
                          ProfileView(),
                        ],
                      )
                  ),
                ),
              ),
              bottomNavigationBar: CustomBottomBarMaterial(
                onTap: controller.changeTabIndex,
                currentIndex: controller.tabIndex,
              )
          );
        }
    );
  }
}
