
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/app_color.dart';
import '../../../share/widget/app_bar.dart';
import '../../../share/widget/app_text.dart';
import '../controller/work_place_lisy_boss_controller.dart';

class WorkPlaceListBossScreen extends GetView<WorkPlaceListBossController> {
  const WorkPlaceListBossScreen({super.key});

  @override
  Widget build(final BuildContext context) {

    Get.lazyPut(()=>WorkPlaceListBossController());
    controller.showActive.value;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.tritry,
        label: const AppText('کارگاه جدید',style: TextStyle(color: Colors.white),),
        icon: const Icon(Icons.add,color: Colors.white,),
        onPressed: (){},),
      appBar: buildAppBar(title: 'لیست کارگاه ها'),


      body: ListView(children: [
      ],),
    );


  }



}