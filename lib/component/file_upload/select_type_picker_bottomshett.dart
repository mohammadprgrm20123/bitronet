import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../infrastructure/theme/app_color.dart';
import '../../infrastructure/utils/utils.dart';
import '../../src/share/widget/app_button.dart';

class SelectTypePickerBottomSheet extends StatelessWidget {
  final void Function()? onTabGallery;
  final void Function()? onTabCamera;
  final void Function()? onTabFiles;
  final bool showGalley;
  final bool showFile;
  final bool showCamera;

  const SelectTypePickerBottomSheet({
     this.onTabGallery,
     this.onTabCamera,
     this.onTabFiles,
    this.showGalley = true,
    this.showFile = true,
    this.showCamera = true,
    super.key,
  });

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if(showCamera)
              AppButton(
                onPressed: onTabCamera,
                text: 'دوربین',
                endIcon: const Icon(
                  LucideIcons.camera,
                  color: Colors.white,
                ),
              ),
              Utils.mediumGap,
              if(showGalley)
              AppButton.outlined(
                onPressed: onTabGallery,
                text: 'گالری',
                endIcon: const Icon(LucideIcons.files),
              ),
              Utils.mediumGap,
              if(showFile)
              AppButton.filled(
                backgroundColor: AppColor.tritry.withOpacity(.7),
                onPressed: onTabFiles,
                borderColor: AppColor.tritry,
                text: 'فایل',
                endIcon: const Icon(
                  LucideIcons.fileSpreadsheet,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
}
