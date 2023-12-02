// ignore_for_file: prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pigemshubshop/app/common/storage/shared_pref.dart';
import 'package:pigemshubshop/app/constants/collections_name.dart';
import 'package:pigemshubshop/app/constants/shared_pref_const.dart';
import 'package:pigemshubshop/config/flavor_config.dart';
import 'package:pigemshubshop/core/domain/entities/account/account.dart';
import 'package:pigemshubshop/core/domain/usecases/auth/login_account.dart';
import 'package:pigemshubshop/core/domain/usecases/auth/logout_account.dart';
import 'package:pigemshubshop/core/domain/usecases/auth/register_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/repositories/pi_analytics_service_impl.dart';

class AuthProvider with ChangeNotifier {
  // Use Case
  final LoginAccount loginAccount;
  final RegisterAccount registerAccount;
  final LogoutAccount logoutAccount;

  AuthProvider(
      {required this.loginAccount,
      required this.registerAccount,
      required this.logoutAccount}) {
    isLoggedIn();
  }

  // Loading State
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool _checkUser = true;

  bool get checkUser => _checkUser;

  // User login state
  bool _isUserLoggedIn = false;

  bool get isUserLoggedIn => _isUserLoggedIn;

  // Check role
  bool _isRoleValid = true;

  bool get isRoleValid => _isRoleValid;

  // Check user login state
  isLoggedIn() async {
    _checkUser = true;
    FirebaseAuth authInstance = FirebaseAuth.instance;

    // If the current user is not null that mean the user already logged in
    if (authInstance.currentUser != null) {
      var data = await FirebaseFirestore.instance
          .collection(CollectionsName.kACCOUNT)
          .doc(authInstance.currentUser!.uid)
          .get();

      Account account = Account.fromJson(data.data()!);

      SharedPref().setString(SharedPrefConstant.saveUserAccount,
          value: data.data()!.toString());

      PiAnalyticsServiceImpl.setupUserDetails(acc: account);

      // Check if user role match the app & is not banned
      if (account.role == FlavorConfig.instance.flavor.roleValue &&
          !account.banStatus) {
        _isUserLoggedIn = true;
        _isRoleValid = true;
      } else {
        authInstance.signOut();
        _isRoleValid = false;
        _isUserLoggedIn = false;
      }
    } else {
      _isUserLoggedIn = false;
    }

    _checkUser = false;
    notifyListeners();
  }

  // Login Method
  Future<void> login({
    required String emailAddress,
    required String password,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await loginAccount.execute(
        email: emailAddress,
        password: password,
      );

      _isLoading = false;
      await isLoggedIn();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Login Error: ${e.toString()}');
      rethrow;
    }
  }

  // Register Method
  Future<void> register({
    required String emailAddress,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await registerAccount.execute(
        email: emailAddress,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
        role: FlavorConfig.instance.flavor.roleValue,
      );

      _isLoading = false;
      isLoggedIn();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Register Error: ${e.toString()}');
      rethrow;
    }
  }

  // Logout Method
  logout() async {
    try {
      await logoutAccount.execute();

      isLoggedIn();
    } catch (e) {
      debugPrint('Logout Error: ${e.toString()}');
      rethrow;
    }
  }

  // Reset Password Method
  resetPassword({required String email}) async {
    try {
      _isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Reset Password Error: ${e.toString()}');
      rethrow;
    }
  }
}
