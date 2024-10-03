import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../infrastructure/utils/utils.dart';
import '../../src/share/widget/app_button.dart';
import '../../src/share/widget/app_text.dart';
import 'file_utils.dart';
import 'select_type_picker_bottomshett.dart';

class AppFilePicker extends StatefulWidget {
  final void Function(List<XFile> files) onFileChange;
  final bool multiImage;
  final String? title;
  final List<XFile>? files;
  final Widget? customWidget;

  const AppFilePicker({
    required this.onFileChange,
    this.multiImage = false,
    this.files,
    this.customWidget,
    super.key,
    this.title,
  });

  @override
  State<AppFilePicker> createState() => _AppFilePickerState();
}

class _AppFilePickerState extends State<AppFilePicker> {
  List<XFile> xFiles = [];

  @override
  void initState() {
    xFiles = widget.files ?? [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    xFiles = widget.files ?? [];
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant final AppFilePicker oldWidget) {
    xFiles = widget.files ?? [];

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) => Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.customWidget == null)
            if (xFiles.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Utils.smallGap,
                    ...xFiles
                        .map(
                          (final e) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.centerRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: FileUtils.isImage(file: e)
                                      ? Image.file(
                                          File(e.path),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                LucideIcons.fileText,
                                                size: 30,
                                              ),
                                              AppText.bodySmall(
                                                FileUtils.getFileType(e),
                                                style: const TextStyle(
                                                    color: Colors.black38),
                                              )
                                            ],
                                          )),
                                ),
                                Positioned(
                                  top: -10,
                                  child: GestureDetector(
                                    onTap: () {
                                      xFiles.remove(e);
                                      widget.onFileChange.call(xFiles);
                                      setState(() {});
                                    },
                                    child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red.shade100),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Icon(
                                            LucideIcons.trash2,
                                            color: Colors.red,
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ).flip(
                              begin: 0,
                              end: 2,
                              duration: const Duration(milliseconds: 500)),
                        )
                        .toList()
                  ],
                ),
              ),
          GestureDetector(
            onTap: () async {
              await openModal(context);
            },
            child: widget.customWidget ??
                Row(
                  children: [
                    Expanded(
                      child: AppButton.outlined(
                        endIcon: const Icon(LucideIcons.plusSquare),
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.1),
                        onPressed: () async {
                          await openModal(context);
                        },
                        text: widget.title ?? 'افزودن فایل',
                      ),
                    ),
                  ],
                ),
          ),
        ],
      );

  Future<void> openModal(final BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        builder: (final c) => SelectTypePickerBottomSheet(
              onTabGallery: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                checkFile(file: image);
              },
              onTabCamera: () async {
                final XFile? photo = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  imageQuality: 20,
                );

                checkFile(file: photo);
              },
              onTabFiles: () async {
                final result = await FilePicker.platform.pickFiles();
                checkFile(file: result?.xFiles.first);
              },
            ));
  }

  void checkFile({final XFile? file}) {
    if (file != null) {
      if (FileUtils.hasStandardFileSize(file: file)) {
        if (FileUtils.fileTypeAccess(file)) {
          addFile(file);
          widget.onFileChange.call(xFiles);
          setState(() {});
        } else {
          Utils.showErrorToast(duration: const Duration(seconds: 5), errors: [
            'فایل آپلودی باید یکی از فرمت های jpg, jpeg, gif, png, zip, rar, pdf باشد.,فرمت فایل آپلودی صحیح نمی باشد.'
          ]);
        }
      } else {
        Utils.showErrorToast(errors: ['سایز باید کم تر از 2 ماگابایت باشد']);
      }
      Navigator.of(context).pop();
    }
  }

  void addFile(final XFile file) {
    if (widget.multiImage) {
      xFiles.add(file);
    } else {
      xFiles.clear();
      xFiles.add(file);
    }
  }
}
