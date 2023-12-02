import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:pigemshubshop/core/domain/repositories/remote_widget_repo.dart';

import '../../app/constants/firebase_remote_const.dart';
import '../../utils/type_def.dart';

class RemoteWidgetImpl implements RemoteWidgetRepo {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteWidgetImpl(this._remoteConfig);

  @override
  Future<void> initRemoteConfig() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 1),
      ),
    );

    await _remoteConfig.setDefaults(FirebaseRemoteConst.remoteDefaultMap);

    await _remoteConfig.fetchAndActivate();
  }

  @override
  Map<String, dynamic> getAppUpdateBool() {
    try {
      final String value = _remoteConfig.getString("app_update");

      if (value.isEmpty) {
        return {};
      } else {
        final Map<String, dynamic> json =
            jsonDecode(value) as Map<String, dynamic>;

        return json;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, dynamic> getHomeScreenDialog() {
    final String value = _remoteConfig.getString("home_screen_dialog_text");
    final MapStringDynamic json = jsonDecode(value) as MapStringDynamic;

    return json;
  }
}
