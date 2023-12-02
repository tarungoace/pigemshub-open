import 'package:firebase_remote_config/firebase_remote_config.dart';

abstract class RemoteWidgetRepo {

  Future<void> initRemoteConfig( );

 Map<String,dynamic> getAppUpdateBool();

 Map<String, dynamic> getHomeScreenDialog();


}
