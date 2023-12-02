import 'package:pigemshubshop/core/domain/repositories/remote_widget_repo.dart';

class GetHomeScreenRemoteDialog {
  final RemoteWidgetRepo _repo;

  GetHomeScreenRemoteDialog(this._repo);

  Map<String, dynamic> execute()  => _repo.getHomeScreenDialog();
}
