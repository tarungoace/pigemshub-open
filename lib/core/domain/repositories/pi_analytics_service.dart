import '../../../app/constants/pi_analytics_enum.dart';

abstract class PiAnalyticsService {
  /// to initialize the underlying libraries
  Future<void> login(PiAnalyticsEnum event);

  Future<void> signup(PiAnalyticsEnum event);

  Future<void> logout(PiAnalyticsEnum event);

  /// to give initial values to underlying libraries and performing setup
  /// or login tasks
  /// It may or may not run immediately after [initialize] and is not a mandatory
  /// function to call



  /// trigger analytics events based on targetted underlying service
  Future<void> triggerLogEvent({
    required PiAnalyticsEnum event,
    Map<String, dynamic>? metaData,
  });

  Future<void> logSelectedContent({
    required PiAnalyticsEnum event,
    required String itemId,
  });

  Future<void> setDefaultEventParameters({Map<String, dynamic>? metaData});
  Future<void> trackScreen({required String screen});

  /// to be called when the service is destroyed
// Future<void> dispose();
}
