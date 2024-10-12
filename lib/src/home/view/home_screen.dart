


import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/theme/app_color.dart';
import '../../share/widget/app_text.dart';
import '../../share/widget/gear_wheel.dart';
import '../../share/widget/logo_with_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    key: UniqueKey(),
      body: BounceInLeft(
        key: UniqueKey(),
        duration: const Duration(milliseconds: 1000),
        child: AppGearWheel(
          buttonBackgroundColor: AppColor.tritry.withOpacity(.8),
          items: [
        
          AppGearWheelItem(icon: Icons.person,onTap: (){},text: 'کارمند'),
          AppGearWheelItem(icon: Icons.supervisor_account_outlined,onTap: (){},text: 'کارفرما'),
        ],
        
        
        ),
      ),
    );



}