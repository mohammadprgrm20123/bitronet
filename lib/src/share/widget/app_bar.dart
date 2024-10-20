import 'package:flutter/material.dart';
import '../../../infrastructure/theme/app_color.dart';
import 'app_text.dart';

AppBar buildAppBar(
        {required final String title, final List<Widget>? actions,final Widget? leading}) =>
    AppBar(
      actions: actions,
      title: AppText(
        title,
        style: const TextStyle(
            color: AppColor.white, fontSize: 18, fontWeight: FontWeight.w400),
      ),
      leading: leading,
      centerTitle: true,
      backgroundColor: AppColor.primary,
    );
