import 'package:flutter/material.dart';
import '../../../infrastructure/theme/app_color.dart';
import 'app_text.dart';

AppBar buildAppBar(
        {required final String title, final List<Widget>? actions}) =>
    AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6))),
      actions: actions,
      title: AppText(
        title,
        style: const TextStyle(
            color: AppColor.white, fontSize: 18, fontWeight: FontWeight.w400),
      ),
      centerTitle: true,
      backgroundColor: AppColor.primary,
    );
