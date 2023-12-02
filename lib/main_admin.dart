import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:pigemshubshop/app/pi_gems_app.dart';
import 'package:pigemshubshop/config/admin_config.dart';
import 'package:pigemshubshop/config/flavor_config.dart';

import 'main_common.dart';

// flutter run --flavor admin -t .\lib\main_admin.dart
void main() async {
  Paint.enableDithering = true;
  await runZonedGuarded(() async {
   await mainCommon();

    FlavorConfig(
      flavor: Flavor.admin,
      flavorValues: FlavorValues(
        roleConfig: AdminConfig(),
      ),
    );

    runApp(const PiGemsApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}
