import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/routing/app_route_name.dart';
import '../../../infrastructure/theme/app_color.dart';
import '../../share/widget/app_bar.dart';
import '../../share/widget/app_text.dart';
import '../../share/widget/exit_dialog.dart';
import '../../share/widget/gear_wheel.dart';
import '../../share/widget/logo_with_image.dart';
import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    Get.lazyPut(()=>HomeController());
    controller.toString();
    return Scaffold(
        appBar: buildAppBar(title: 'Bitronet'),
        key: UniqueKey(),
        body: BounceInLeft(
          key: UniqueKey(),
          duration: const Duration(milliseconds: 1000),
          child: AppGearWheel(
            buttonBackgroundColor: AppColor.tritry.withOpacity(.8),
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
        ),
      );
  }
}
