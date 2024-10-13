import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'infrastructure/handlers/timer_handler.dart';
import 'infrastructure/routing/app_pages.dart';
import 'infrastructure/routing/app_route_name.dart';
import 'infrastructure/theme/app_theme.dart';
import 'src/share/widget/loading.dart';

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(final SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback = (final cert, final host, final port) => true;
}

void main() async {
  HttpOverrides.global = MyHttpOverride();
  WidgetsFlutterBinding.ensureInitialized();
  await GetSecureStorage.init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
    runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Listener(
        onPointerDown: (final c) {
          TimerHandler.startTimer();
        },
        child: GetMaterialApp.router(
          title: 'Bitronet',
          theme: AppTheme().themeData,
          debugShowCheckedModeBanner: false,
          locale: const Locale('fa'),
          defaultTransition: Transition.cupertino,
          builder: (final c, final child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaleFactor.clamp(.95, .95);
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.linear(scale)),
                child: Loading(child: child!));
          },
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
              PointerDeviceKind.unknown,
            },
          ),
          routeInformationParser: GetInformationParser(
            initialRoute: AppRouteName.splashRoute,
          ),
          getPages: AppPages.appPages,
        ),
      );

}
