import 'package:pigemshubshop/core/domain/repositories/remote_widget_repo.dart';

class GetAppUpdateRemoteConfig {
  final RemoteWidgetRepo _repo;

  GetAppUpdateRemoteConfig(this._repo);

 Map<String, dynamic> execute()  => _repo.getAppUpdateBool();
}
