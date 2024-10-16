import 'package:flutter/material.dart';

import 'app_color.dart';
import 'theme_constants.dart';

class AppTheme {
  static const Color _surface = Colors.black;
  final ThemeData themeData = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.light,
    useMaterial3: true,
    canvasColor: AppColor.grey,
    textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColor.primary,
        selectionHandleColor: Colors.black,
        selectionColor: Colors.grey),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: AppColor.primary),
    unselectedWidgetColor: Colors.grey,
    applyElevationOverlayColor: true,
    iconTheme: const IconThemeData(
      color: AppColor.primary,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((final states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColor.primary;
        }
        return Colors.grey;
      }),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor:
              WidgetStateProperty.resolveWith<Color?>((final states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey;
            }
            if (states.contains(WidgetState.selected)) {
              return AppColor.secondary2;
            }
            return Colors.grey;
          }),
        ),
        inputDecorationTheme: const InputDecorationTheme()),
    dialogBackgroundColor: AppColor.white,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColor.white,
      iconColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColor.primary,
        titleTextStyle: TextStyle(
            fontSize: 18,
            fontFamily: ThemeConstants.fontFamily,
            fontWeight: FontWeight.bold,
            color: Colors.white),
        centerTitle: true),
    inputDecorationTheme: InputDecorationTheme(
        // isDense: true,
        // hintStyle: const TextStyle(color: Colors.black54),
        // counterStyle: const TextStyle(color: AppColor.grey),
        // helperStyle: const TextStyle(color: AppColor.grey),
        labelStyle: const TextStyle(
          color: AppColor.primary,
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.error, width: 2),
            borderRadius: BorderRadius.circular(16)),
        errorStyle: const TextStyle(color: AppColor.error),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.error, width: 2),
            borderRadius: BorderRadius.circular(16)),
        iconColor: AppColor.primary,
        suffixIconColor: AppColor.primary,
        prefixIconColor: AppColor.primary,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.secondary2, width: 2),
            borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.primary, width: 2),
            borderRadius: BorderRadius.circular(16))),
    colorScheme: ColorScheme.fromSeed(
        primary: AppColor.primary,
        onSurface: Colors.grey,
        secondary: AppColor.secondary,
        tertiary: AppColor.tritry,
        background: AppColor.tritry,
        error: AppColor.primary,
        onBackground: AppColor.tritry,
        onSecondary: Colors.white,
        onTertiary: AppColor.secondary2,
        seedColor: AppColor.primary),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: AppColor.secondary2,
    ),
    scaffoldBackgroundColor: AppColor.secondary,
    dividerColor: const Color(0xFFBFBFBF),
    fontFamily: ThemeConstants.fontFamily,
    disabledColor: const Color(0xFFE7E7E7),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 10,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedItemColor: AppColor.primary,
      unselectedItemColor: AppColor.grey,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontSize: 11,
        color: Color(0xFF677896),
        fontFamily: ThemeConstants.fontFamily,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 10,
        color: Color(0xFF575757),
        fontFamily: ThemeConstants.fontFamily,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
      titleMedium: TextStyle(
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400),
      titleSmall: TextStyle(
        fontSize: 14,
        letterSpacing: 0.1,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        letterSpacing: 0.1,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        letterSpacing: 0.5,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        letterSpacing: 0.5,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      bodyLarge: TextStyle(
        fontSize: 14,
        letterSpacing: 0.15,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(
        fontSize: 11,
        letterSpacing: 0.4,
        overflow: TextOverflow.ellipsis,
        color: Colors.black,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.grey[600])),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              ThemeConstants.borderRadius,
            ),
          ),
        ),
        elevation: 5,
        shadowColor: Colors.black,
        // disabledBackgroundColor: AppColor.tritry,
        // disabledForegroundColor: AppColor.tritry,
        // foregroundColor: AppColor.tritry,
        textStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 22,
          fontFamily: ThemeConstants.fontFamily,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColor.primary),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            color: AppColor.primary,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              ThemeConstants.borderRadius,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: AppColor.grey,
        minimumSize: const Size(
          48,
          49,
        ),
        maximumSize: const Size(
          double.infinity,
          49,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              ThemeConstants.borderRadius,
            ),
          ),
        ),
        iconColor: AppColor.primary,
        minimumSize: const Size(
          48,
          40,
        ),
        maximumSize: const Size(
          double.infinity,
          49,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        textStyle: const TextStyle(
          color: AppColor.primary,
          fontWeight: FontWeight.w500,
          fontSize: 12,
          fontFamily: ThemeConstants.fontFamily,
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStateProperty.all(AppColor.primary),
        fillColor: WidgetStateProperty.resolveWith(
          (final states) => states.contains(WidgetState.pressed)
              ? null
              : AppColor.secondary2,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(color: AppColor.primary)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFBFBFBF),
      thickness: 1,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black,
    ),
    cardTheme: const CardTheme(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            ThemeConstants.borderRadius,
          ),
        ),
      ),
    ),
  );
}
