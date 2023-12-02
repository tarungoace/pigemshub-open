import 'package:pigemshubshop/config/role_config.dart';
import 'package:pigemshubshop/themes/custom_bottom_sheet.dart';
import 'package:pigemshubshop/themes/custom_input_decoration.dart';
import 'package:pigemshubshop/themes/custom_text_theme.dart';
import 'package:flutter/material.dart';

class UserConfig implements RoleConfig {
  // TODO: Change App Name
  @override
  String appName() {
    return 'PiGemsHub Shop';
  }

  // TODO: Change App Primary Color
  @override
  Color primaryColor() {
    return const Color(0xFFbcacdc);
  }

  // TODO: Change App Primary Dark Color
  @override
  Color primaryDarkColor() {
    return const Color(0xFF745cb4);
  }

  @override
  ThemeData theme() {
    return ThemeData(
      primaryColor: primaryColor(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor(),
      ),
      useMaterial3: true,
      textTheme: CustomTextTheme.textTheme,
      inputDecorationTheme: CustomInputDecoration.inputDecorationTheme,
      bottomSheetTheme: CustomBottomSheet.bottomSheetThemeData,
    );
  }

  @override
  ThemeData darkTheme() {
    return ThemeData(
      primaryColorDark: primaryDarkColor(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryDarkColor(),
        brightness: Brightness.dark,
      ),
      splashColor: Colors.white,
      splashFactory: NoSplash.splashFactory,
      useMaterial3: true,
      textTheme: CustomTextTheme.textTheme,
      inputDecorationTheme: CustomInputDecoration.inputDecorationTheme,
      bottomSheetTheme: CustomBottomSheet.bottomSheetThemeData,
    );
  }
}
