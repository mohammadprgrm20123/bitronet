import 'package:flutter/material.dart';


enum LevelStatus {
  a('طلایی', Color(0xffebb447)),
  b('نقره ای', Color(0xffC0C0C0)),
  c('برنزی', Color(0xffCD7F32));

  final String title;
  final Color color;

  const LevelStatus(this.title, this.color);

  static LevelStatus convert(final String value) {
    switch (value) {
      case 'A':
        return LevelStatus.a;
      case 'B':
        return LevelStatus.b;
      case 'C':
        return LevelStatus.c;
    }

    return LevelStatus.c;
  }
}
