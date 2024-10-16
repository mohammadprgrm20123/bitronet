import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../infrastructure/routing/app_route_name.dart';
import '../../../infrastructure/theme/app_color.dart';
import '../../share/widget/app_bar.dart';
import '../../share/widget/exit_dialog.dart';
import '../../share/widget/gear_wheel.dart';
import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    Get.lazyPut(HomeController.new);
    controller.toString();
    return Scaffold(
      appBar: buildAppBar(
        title: 'داشبورد',
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Icon(Icons.person_rounded),
          ),
        ),
      ),
      key: UniqueKey(),
      body: BounceInLeft(
        key: UniqueKey(),
        duration: const Duration(milliseconds: 1000),
        child: Stack(
          children: [
            AppGearWheel(
              selectedColor: AppColor.primary,
              logo: Shimmer.fromColors(
                baseColor: AppColor.primary,
                highlightColor: AppColor.primary,
                child: Image.asset(
                  'assets/images/bitronet.png',
                  width: 80,
                ),
              ),
              lineColor: AppColor.primary,
              buttonBackgroundColor: AppColor.tritry,
              // buttonBackgroundColor: AppColor.primary.withOpacity(.8),
              items: [
                AppGearWheelItem(
                    icon: Icons.person, onTap: () {}, text: 'کارمند'),
                AppGearWheelItem(
                    icon: Icons.supervisor_account_outlined,
                    onTap: () {
                      print(AppRouteName.workPLaceBossRoute);
                      Get.toNamed(AppRouteName.workPLaceBossRoute);
                    },
                    text: 'کارفرما'),
                AppGearWheelItem(
                    icon: Icons.exit_to_app,
                    onTap: () async {
                      await showDialog(
                          context: context, builder: (c) => const ExitDialog());
                    },
                    text: 'خروج از حساب کاربری'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
