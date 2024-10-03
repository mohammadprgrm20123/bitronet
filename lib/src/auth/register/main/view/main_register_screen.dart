import 'package:flutter/material.dart';

import '../../../../../infrastructure/utils/utils.dart';
import '../../../../share/widget/app_text.dart';
import '../../../../share/widget/logo_with_image.dart';
import '../../legal_account_register/view/lecal_account_register_screen.dart';

class MainRegisterScreen extends StatelessWidget {
  const MainRegisterScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Padding(
            padding: Utils.mediumPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Utils.largeGap,
                Utils.largeGap,
                const LogoWithImage(),
                Utils.largeGap,
                Utils.mediumGap,
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.onTertiary),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).colorScheme.primary),
                      onTap: (final index) {},
                      labelColor: Colors.white,
                      tabs: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText('حساب حقیقی'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppText('حساب حقوقی'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  child: LegalAccountRegisterScreen(),
                ),
              ],
            ),
          ),
        ),
      );
}
