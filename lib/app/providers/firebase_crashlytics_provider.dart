import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pigemshubshop/app/common/storage/shared_pref.dart';
import 'package:pigemshubshop/app/constants/shared_pref_const.dart';
import 'package:pigemshubshop/core/domain/entities/account/account.dart';

import '../../utils/type_def.dart';

class CrashlyticsProvider extends ChangeNotifier {
  final FirebaseCrashlytics _instance;

  CrashlyticsProvider(this._instance);

  late Account? _account;

  init() async {
    await _instance.setCrashlyticsCollectionEnabled(true);

    MapStringDynamic? json = jsonDecode(
            (await SharedPref().getString(SharedPrefConstant.saveUserAccount))!)
        as MapStringDynamic;

    _account = Account.fromJson(json);
    _setByUser();
  }

  bool get isEnabled => _instance.isCrashlyticsCollectionEnabled;

  testCrash() {
    _instance.crash();
  }

  _setByUser() {
    if (_account != null) {
      _instance.setUserIdentifier(_account!.fullName.replaceAll(" ", ""));
    }
  }

  setCustomKey() {
    _instance.setCustomKey('str_key', 'hello');
  }

  setLogs() {
    FirebaseCrashlytics.instance.log("Higgs-Boson detected! Bailing out");
  }
}
