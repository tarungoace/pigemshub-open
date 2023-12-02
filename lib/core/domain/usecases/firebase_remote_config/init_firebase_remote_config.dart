import 'package:pigemshubshop/core/domain/repositories/remote_widget_repo.dart';

import '../../../../app/constants/firebase_remote_const.dart';

class InitFirebaseRemoteConfig {
  final RemoteWidgetRepo _repo;

  InitFirebaseRemoteConfig(this._repo);

  Future<void> execute() async =>
      _repo.initRemoteConfig();
}
