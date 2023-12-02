import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:pigemshubshop/app/pi_gems_app.dart';
import 'package:pigemshubshop/config/flavor_config.dart';
import 'package:pigemshubshop/config/user_config.dart';

import 'main_common.dart';

// flutter run --flavor user -t .\lib\main_user.dart
void main() async {
  Paint.enableDithering = true;
  await runZonedGuarded(() async {
   await mainCommon();

    FlavorConfig(
      flavor: Flavor.user,
      flavorValues: FlavorValues(
        roleConfig: UserConfig(),
      ),
    );

    runApp(const PiGemsApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
