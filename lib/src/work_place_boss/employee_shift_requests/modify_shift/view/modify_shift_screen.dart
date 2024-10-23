import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:text_divider/text_divider.dart';

import '../../../../../infrastructure/theme/app_color.dart';
import '../../../../../infrastructure/theme/theme_constants.dart';
import '../../../../../infrastructure/utils/utils.dart';
import '../../../../share/widget/app_bar.dart';
import '../../../../share/widget/app_button.dart';
import '../../../../share/widget/app_text.dart';
import '../../../../share/widget/column_data_title.dart';
import '../../main/model/day_name.dart';
import '../controller/modify_shift_controller.dart';
import '../model/add_shift_dto.dart';

class ModifyShiftScreen extends StatefulWidget {
  const ModifyShiftScreen({super.key});

  @override
  State<ModifyShiftScreen> createState() => _ModifyShiftScreenState();
}

class _ModifyShiftScreenState extends State<ModifyShiftScreen> {
  final ClockTimeFormat _clockTimeFormat = ClockTimeFormat.twentyFourHours;
  TextEditingController nameController = TextEditingController();
  final ClockIncrementTimeFormat _clockIncrementTimeFormat =
      ClockIncrementTimeFormat.fiveMin;
  GlobalKey<FormState> formKey = GlobalKey();
  PickedTime startTime = PickedTime(h: 7, m: 0);
  PickedTime endTime = PickedTime(h: 15, m: 0);
  RxInt selectedHoliday = 7.obs;
  RxBool globalHoliday = false.obs;
  RxBool fixedLocation = false.obs;
  RxBool needPhoto = false.obs;

  final ModifyShiftController controller = Get.put(
      ModifyShiftController(Get.parameters['id'] ?? ''));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) =>
      Scaffold(
        appBar: buildAppBar(title: 'شیفت جدید'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ColumnDataTitle(
                      isRequired: true,
                      title: 'نام شیفت',
                      textForm: TextFormField(
                        controller: nameController,
                      )),
                  Utils.mediumGap,
                  ColumnDataTitle(
                      isRequired: true,
                      title: 'انتخاب روز تعطیل',
                      textForm: DropdownButtonFormField<int>(
                          dropdownColor: Colors.white,
                          items: [
                            0,
                            1,
                            2,
                            3,
                            4,
                            5,
                            6,
                            7,
                          ]
                              .map((e) =>
                              DropdownMenuItem<int>(
                                  value: e, child: AppText('${e
                                  .getDayName()}')))
                              .toList(),
                          onChanged: (c) {
                            if(c!=null){
                            selectedHoliday.value = c;
                            }

                          })),
                  Utils.mediumGap,
                  Utils.mediumGap,
                  const TextDivider(text: Text('ساعت کاری')),
                  Utils.mediumGap,
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TimePicker(
                      initTime: startTime,
                      endTime: endTime,
                      height: 250.0,
                      width: 250.0,
                      isEndHandlerSelectable: true,
                      isInitHandlerSelectable: true,
                      isSelectableHandlerMoveAble: true,
                      drawInitHandlerOnTop: true,

                      onSelectionChange: _updateLabels,
                      onSelectionEnd:
                          (final start, final end, final isDisableRange) =>
                          print(
                              'onSelectionEnd => init : ${start.h}:${start
                                  .m}, end : ${end.h}:${end
                                  .m}, isDisableRange: $isDisableRange'),
                      primarySectors: _clockTimeFormat.value,
                      secondarySectors: _clockTimeFormat.value * 2,
                      decoration: TimePickerDecoration(
                        baseColor: const Color(0xFF1F2633),
                        pickerBaseCirclePadding: 5.0,
                        sweepDecoration: TimePickerSweepDecoration(
                          pickerStrokeWidth: 10.0,
                          pickerColor: AppColor.tritry,
                          showConnector: true,
                        ),
                        initHandlerDecoration: TimePickerHandlerDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                          radius: 15.0,
                          icon: const Icon(
                            Icons.sunny,
                            size: 20.0,
                            color: AppColor.purple,
                          ),
                        ),
                        endHandlerDecoration: TimePickerHandlerDecoration(
                          color: AppColor.primary,
                          shape: BoxShape.circle,
                          radius: 15.0,
                          icon: const Icon(
                            Icons.nightlight,
                            size: 20.0,
                            color: AppColor.purple,
                          ),
                        ),
                        primarySectorsDecoration: TimePickerSectorDecoration(
                          color: Colors.red,
                          width: 1.0,
                          size: 4.0,
                          radiusPadding: 20.0,
                        ),
                        secondarySectorsDecoration: TimePickerSectorDecoration(
                          color: AppColor.primary,
                          width: 1.0,
                          size: 2.0,

                          radiusPadding: 25.0,
                        ),
                        clockNumberDecoration: TimePickerClockNumberDecoration(
                          defaultTextColor: AppColor.primary,
                          endNumber: 24,
                          clockIncrementHourFormat: ClockIncrementHourFormat
                              .three,
                          textStyle: const TextStyle(
                              fontSize: 15,
                              color: AppColor.primary,
                              fontFamily: ThemeConstants.fontFamily),
                          showNumberIndicators: true,
                          clockTimeFormat: _clockTimeFormat,
                          clockIncrementTimeFormat: _clockIncrementTimeFormat,
                        ),
                      ),
                    ),
                  ),
                  Utils.smallGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final result = await showPersianTimePicker(
                              builder: (final c, final child) =>
                                  MediaQuery(
                                      data: MediaQuery.of(context)
                                          .copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!),
                              initialEntryMode: PTimePickerEntryMode.inputOnly,
                              context: context,
                              initialTime: TimeOfDay(
                                  hour: startTime.h, minute: startTime.m));

                          if (result != null) {
                            startTime =
                                PickedTime(h: result.hour, m: result.minute);
                            setState(() {});
                          }
                        },
                        child: _timeWidget(
                          'ساعت شروع',
                          startTime,
                          const Icon(
                            Icons.sunny,
                            size: 25.0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final result = await showPersianTimePicker(
                              builder: (final c, final child) =>
                                  MediaQuery(
                                      data: MediaQuery.of(context)
                                          .copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!),
                              initialEntryMode: PTimePickerEntryMode.inputOnly,
                              context: context,
                              initialTime:
                              TimeOfDay(hour: endTime.h, minute: endTime.m));

                          if (result != null) {
                            endTime =
                                PickedTime(h: result.hour, m: result.minute);
                            setState(() {});
                          }
                        },
                        child: _timeWidget(
                          'ساعت پایان',
                          endTime,
                          const Icon(
                            Icons.nightlight,
                            size: 25.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Utils.mediumGap,
                  const TextDivider(text: Text('تنطیمات  شیفت')),
                  Utils.smallGap,
                  Obx(() =>
                      SwitchListTile(
                        value: globalHoliday.value,
                        onChanged: (final c) {
                          globalHoliday.toggle();
                        },
                        title: const AppText('دارای تعطیلات رسمی'),
                      )),
                  Obx(() =>
                      SwitchListTile(
                        value: fixedLocation.value,
                        onChanged: (final c) {
                          fixedLocation.toggle();
                        },
                        title: const AppText(
                          'الزام به حضور در محل کارگاه (عدم ماموریت خارج از شرکت)',
                          overflow: TextOverflow.visible,
                        ),
                      )),
                  Obx(() =>
                      SwitchListTile(
                        value: needPhoto.value,
                        onChanged: (final c) {
                          needPhoto.toggle();
                        },
                        title: const AppText('الزام به عکس سلفی در ماموریت'),
                      )),
                  Utils.largeGap,
                  Utils.largeGap,
                  Utils.largeGap,
                  AppButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        controller.addShift(dto: AddShiftDto(id: 0,
                            workplace: Workplace(id: int.parse(controller.id)),
                            name: nameController.text,
                            fromHour: '${startTime.h}:${startTime.m}',
                            toHour: '${endTime.h}:${endTime.m}',
                            globalHoliday: globalHoliday.value,
                            dayOff: selectedHoliday.value,
                            justPlace: fixedLocation.value,
                            needPhoto: needPhoto.value));
                      }
                    },
                    text: 'ذخیره شیفت',
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget _timeWidget(final String title, final PickedTime time,
      final Icon icon) =>
      Container(
        width: 150.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '${intl.NumberFormat('00').format(time.h)}:${intl.NumberFormat(
                    '00').format(time.m)}',
                style: const TextStyle(
                  color: AppColor.primary,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$title',
                style: const TextStyle(
                  color: AppColor.primary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );

  void _updateLabels(final PickedTime init, final PickedTime end,
      final bool? isDisableRange) {
    startTime = init;
    endTime = end;
    setState(() {});
  }
}
