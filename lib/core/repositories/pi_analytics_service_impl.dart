import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:pigemshubshop/app/constants/pi_analytics_enum.dart';
import 'package:pigemshubshop/core/domain/entities/account/account.dart';

import '../domain/repositories/pi_analytics_service.dart';

class PiAnalyticsServiceImpl extends PiAnalyticsService {
  static PiAnalyticsServiceImpl? _object;

  factory PiAnalyticsServiceImpl() {
    if (_object == null) {
      return _object = PiAnalyticsServiceImpl._();
    }
    return _object!;
  }

  PiAnalyticsServiceImpl._();

  late final FirebaseAnalytics _instance = FirebaseAnalytics.instance;

  static setupUserDetails({required Account acc}) async {
    await FirebaseAnalytics.instance.setUserId(id: acc.accountId);
    await FirebaseAnalytics.instance.setUserProperty(
      name: acc.fullName.replaceAll(" ", "") ?? "",
      value: acc.role.toString(),
      callOptions: AnalyticsCallOptions(global: true),
    );
  }

  @override
  Future<void> login(PiAnalyticsEnum event) async {
    await _instance.logLogin(loginMethod: event.name);
  }

  @override
  Future<void> logout(PiAnalyticsEnum event) async {}

  @override
  Future<void> signup(PiAnalyticsEnum event) async {
    await _instance.logSignUp(signUpMethod: event.name);
  }


  @override
  Future<void> triggerLogEvent(
      {required PiAnalyticsEnum event, Map<String, dynamic>? metaData}) async {
    await _instance.logEvent(name: event.name, parameters: metaData);
  }

  @override
  Future<void> logSelectedContent(
      {required PiAnalyticsEnum event, required String itemId}) async {
    await FirebaseAnalytics.instance.logSelectContent(
      contentType: "image",
      itemId: itemId,
    );
  }

  ///Default Has to be from App Version, Date etc
  @override
  Future<void> setDefaultEventParameters(
      {Map<String, dynamic>? metaData}) async {

    // Not supported on web
    await FirebaseAnalytics.instance.setDefaultEventParameters(
      {
        "logout": "default_logout",
        "email_login": "default_email_login",
        "email_signup": "default_email_signup",
        "bottom_navigation_event": "default_bottom_navigation_event",
      },
    );
  }

  @override
  Future<void> trackScreen({required String screen}) async {
    await FirebaseAnalytics.instance.setCurrentScreen(screenName: screen);
  }

  ///There are major analytics event for Ecommerce log event also
}
