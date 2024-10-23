import 'package:flutter/material.dart';
import '../../../../../../infrastructure/theme/app_color.dart';
import '../../../../../../infrastructure/utils/utils.dart';

import '../../../../../share/widget/app_text.dart';
import '../../../../../share/widget/delete_dialog.dart';
import '../../../../../share/widget/row_builder.dart';

import '../../model/day_name.dart';
import '../../model/shift_model.dart';

class ShiftItem extends StatelessWidget {
  final void Function() onTap;
  final ShiftModel model;

  const ShiftItem({
    required this.model,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(final BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4),
          child: DecoratedBox(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: AppColor.grey.withOpacity(.5),
                  offset: Offset(1, 1),
                  blurRadius: 1,
                  spreadRadius: .2)
            ], borderRadius: BorderRadius.circular(16), color: AppColor.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: onTap,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColor.primary.withOpacity(.08)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: AppText(
                                'شیفت : ${model.name}',
                                style: style(context)
                                    .copyWith(color: AppColor.primary),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton<int>(
                      padding: EdgeInsets.zero,

                      onSelected: (final value) async {
                        if (value == 0) {
                          await showDialog(
                              context: context,
                              builder: (final c) => DeleteDialog(onDelete: () {

                              }));
                        }


                        if (value == 1) {

                        }
                      },
                      itemBuilder: (final context) => [
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline,
                                size: 20,
                                color: AppColor.error,
                              ),
                              Utils.tinyGap,
                              AppText('حذف'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<int>(
                          value: 1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_note_sharp,
                                size: 20,
                                color: AppColor.primary,
                              ),
                              Utils.tinyGap,
                              AppText('ویرایش'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 4),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          RowBuilder(
                            icon: Icon(
                              Icons.sunny,
                              color: Colors.yellow[900],
                              size: 15,
                            ),
                            value: model.fromHour,
                            title: 'ساعت شروع:',
                            valueFlex: 0,
                            titleFlex: 0,
                          ),
                          Utils.mediumGap,
                          RowBuilder(
                            icon: Icon(
                              Icons.nightlight,
                              color: Colors.yellow[900],
                              size: 15,
                            ),
                            value: model.toHour,
                            title: 'ساعت پایان:',
                            valueFlex: 0,
                            titleFlex: 0,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: .4,
                      ),
                      RowBuilder(
                        value: model.toHour,
                        valueFlex: 0,
                        titleFlex: 0,
                        title: 'روز تعطیل:',
                        valueWidget: DecoratedBox(
                          decoration: BoxDecoration(
                            // color: AppColor.error.withOpacity(.1)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: AppText(
                              model.dayOff.getDayName(),
                              style: TextStyle(shadows: [
                                Shadow(
                                    color: AppColor.error,
                                    blurRadius: 30,
                                    offset: Offset(0, 2)),
                              ], color: AppColor.error),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: .2,
                      ),
                      RowBuilder(
                        value: model.toHour,
                        title: 'دارای تعطیلات رسمی:',
                        valueWidget: Icon(
                          model.globalHoliday ? Icons.check_circle_rounded :  Icons.remove_circle_outlined,
                          size: 18,
                          color:model.globalHoliday ? AppColor.success : AppColor.error,
                        ),
                      ),
                      RowBuilder(
                        value: model.toHour,
                        title: 'الزام به حضور در محل کارگاه :',
                        valueWidget: Icon(
                          model.justPlace ? Icons.check_circle_rounded :   Icons.remove_circle_outlined,
                          color:model.justPlace ? AppColor.success : AppColor.error,
                          size: 18,
                        ),
                      ),
                      RowBuilder(
                        value: model.toHour,
                        title: 'الزام به عکس سلفی:',
                        valueWidget: Icon(
                          model.needPhoto ? Icons.check_circle_rounded :  Icons.remove_circle_outlined,
                          size: 18,
                          color:model.needPhoto ? AppColor.success : AppColor.error,
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      );

  TextStyle style(final BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white);
}
