import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String name;
  final Color? color;
  final double size;


  const SvgIcon({super.key, required this.name, this.color=Colors.grey, this.size= 15});

  @override
  Widget build(final BuildContext context) =>
      SvgPicture.asset('assets/images/$name.svg',
        width: size,
        height: size,
        colorFilter: color == null ? null : ColorFilter.mode(
            color!, BlendMode.srcATop),);


}