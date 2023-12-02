import 'package:flutter/material.dart';
import 'package:pigemshubshop/core/domain/usecases/firebase_remote_config/get_app_update_remote.dart';
import 'package:pigemshubshop/core/domain/usecases/firebase_remote_config/get_home_screen_remote_dialog.dart';
import 'package:pigemshubshop/core/domain/usecases/firebase_remote_config/init_firebase_remote_config.dart';
import 'package:pigemshubshop/utils/type_def.dart';

class FirebaseRemoteWidgetProvider extends ChangeNotifier {
  final InitFirebaseRemoteConfig _initFirebaseRemoteConfig;
  final GetAppUpdateRemoteConfig _getAppUpdateRemoteConfig;
  final GetHomeScreenRemoteDialog _getHomeScreenRemoteDialog;

  FirebaseRemoteWidgetProvider(this._initFirebaseRemoteConfig,
      this._getAppUpdateRemoteConfig, this._getHomeScreenRemoteDialog);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  late Map<String, dynamic> _remoteAppUpdateMap;

  late Map<String, dynamic> _remoteHomeScreenMap;

  Map<String, dynamic> get remoteAppUpdateMap => _remoteAppUpdateMap;

  Map<String, dynamic> get remoteHomeScreen => _remoteHomeScreenMap;

  initFirebaseRemoteConfig() async {
    await _initFirebaseRemoteConfig.execute();
  }

  MapStringDynamic getAppUpdateRemoteConfig() {
    try {
      _isLoading = true;
      _remoteAppUpdateMap = _getAppUpdateRemoteConfig.execute();
      _isLoading = false;
      notifyListeners();
      return _remoteAppUpdateMap;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  MapStringDynamic getHomeScreenRemoteDialog() {
    try {
      _isLoading = true;
      _remoteHomeScreenMap = _getHomeScreenRemoteDialog.execute();
      notifyListeners();
      return _remoteHomeScreenMap;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
