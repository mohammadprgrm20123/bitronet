import 'package:bitronet_attendance/src/work_place_boss/employee_shift_requests/main/view/tabs/shift_list_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../infrastructure/theme/app_color.dart';
import '../../../../../infrastructure/utils/utils.dart';
import '../../../../share/widget/app_bar.dart';
import '../../../../share/widget/app_text.dart';
import '../controller/main_tab_boss_controller.dart';

class MainTabBossScreen extends GetView<MainTabBossController> {
  final String workPlaceName;

  const MainTabBossScreen({
    required this.workPlaceName,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    Get.lazyPut(() => MainTabBossController(Get.parameters['id'] ?? ''));

    controller.workPLaceId;

    return Scaffold(
      appBar: buildAppBar(title: 'کارگاه/شرکت : ($workPlaceName)'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: AppColor.primary.withOpacity(.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: SizedBox(
                        height: 35,
                        child: TabBar(
                          dividerHeight: 0,
                          indicatorWeight: 0,
                          padding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            labelColor: AppColor.primary,
                            unselectedLabelColor: Colors.black12,
                            indicator: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(8)),
                            tabs: [
                              Tab(
                                child: AppText.bodySmall(
                                  'کارمندان',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.textColor,
                                      fontSize: 12),
                                ),
                              ),
                              Tab(
                                child: AppText.bodySmall(
                                  'شیفت ها',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.textColor,
                                      fontSize: 12),
                                ),
                              ),
                              Tab(
                                child: AppText.bodySmall(
                                  'درخواست ها',
                                  style: TextStyle(
                                      color: AppColor.textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ]),
                      ),
                    ),
                     Utils.smallGap,
                     Expanded(
                      child: TabBarView(children: [
                        Text('sd'),
                        ShiftListTabScreen(),
                        Text('sd'),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
