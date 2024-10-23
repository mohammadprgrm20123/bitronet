import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../../infrastructure/routing/app_route_name.dart';
import '../../../../../../infrastructure/theme/app_color.dart';
import '../../../../../../infrastructure/utils/utils.dart';
import '../../../../../share/widget/app_text.dart';
import '../../../../../share/widget/loading_widget.dart';
import '../../../../../share/widget/retry_widget.dart';
import '../../controller/main_tab_boss_controller.dart';
import '../../model/shift_model.dart';
import '../widget/shift_item.dart';

class ShiftListTabScreen extends GetView<MainTabBossController> {
  const ShiftListTabScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColor.tritry,
          extendedPadding: const EdgeInsets.symmetric(horizontal: 8),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          label: const AppText(
            'شیفت جدید',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            final result =await Get.toNamed(AppRouteName.modifyShiftRoute(
                title: Get.parameters['title'] ?? '',
                id: Get.parameters['id'] ?? ''));


            if(result!=null){
              controller.shiftPagingController.refresh();
            }
            },
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.shiftPagingController.refresh();
          },
          child: PagedListView<int, ShiftModel>(
            pagingController: controller.shiftPagingController,
            padding: EdgeInsets.zero,
            builderDelegate: PagedChildBuilderDelegate<ShiftModel>(
              noItemsFoundIndicatorBuilder: (final c) => const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Utils.giantGap,
                  Center(child: Text('شیفتی ثبت نشده است')),
                ],
              ),
              firstPageErrorIndicatorBuilder: (final e) => RetryWidget(
                  onRetry: () => controller.shiftPagingController.refresh()),
              itemBuilder: (final context, final item, final index) =>
                  ((controller.shiftPagingController.itemList!.length - 1) !=
                          index)
                      ? ShiftItem(
                          model: item,
                          onTap: () async {},
                        )
                      : Column(
                          children: [
                            ShiftItem(
                              model: item,
                              onTap: () async {},
                            ),
                            Utils.giantGap,
                            Utils.giantGap,
                            Utils.giantGap,
                          ],
                        ),
            ),
          ),
        ),
      );
}
