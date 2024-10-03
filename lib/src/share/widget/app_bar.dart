import 'package:flutter/material.dart';
import 'app_text.dart';

AppBar buildAppBar({required final String title,final List<Widget>? actions}) => AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6))),
      actions: actions,
      title: AppText.titleMedium(title),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
