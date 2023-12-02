import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pigemshubshop/app/common/storage/shared_pref.dart';
import 'package:pigemshubshop/app/constants/collections_name.dart';
import 'package:pigemshubshop/app/constants/shared_pref_const.dart';
import 'package:pigemshubshop/app/pages/navigation/bottom_navigation.dart';
import 'package:pigemshubshop/app/providers/account_provider.dart';
import 'package:pigemshubshop/app/providers/address_provider.dart';
import 'package:pigemshubshop/app/providers/auth_provider.dart';
import 'package:pigemshubshop/app/providers/cart_provider.dart';
import 'package:pigemshubshop/app/providers/checkout_provider.dart';
import 'package:pigemshubshop/app/providers/dark_mode_provider.dart';
import 'package:pigemshubshop/app/providers/firebase_crashlytics_provider.dart';
import 'package:pigemshubshop/app/providers/firebase_remote_widget_provider.dart';
import 'package:pigemshubshop/app/providers/payment_method_provider.dart';
import 'package:pigemshubshop/app/providers/product_provider.dart';
import 'package:pigemshubshop/app/providers/transaction_provider.dart';
import 'package:pigemshubshop/app/providers/wishlist_provider.dart';
import 'package:pigemshubshop/config/flavor_config.dart';
import 'package:pigemshubshop/core/domain/usecases/account/ban_account.dart';
import 'package:pigemshubshop/core/domain/usecases/account/get_account_profile.dart';
import 'package:pigemshubshop/core/domain/usecases/account/get_all_account.dart';
import 'package:pigemshubshop/core/domain/usecases/account/update_account.dart';
import 'package:pigemshubshop/core/domain/usecases/address/add_address.dart';
import 'package:pigemshubshop/core/domain/usecases/address/change_primary_address.dart';
import 'package:pigemshubshop/core/domain/usecases/address/delete_address.dart';
import 'package:pigemshubshop/core/domain/usecases/address/get_account_address.dart';
import 'package:pigemshubshop/core/domain/usecases/address/update_address.dart';
import 'package:pigemshubshop/core/domain/usecases/auth/login_account.dart';
import 'package:pigemshubshop/core/domain/usecases/auth/logout_account.dart';
import 'package:pigemshubshop/core/domain/usecases/auth/register_account.dart';
import 'package:pigemshubshop/core/domain/usecases/cart/add_account_cart.dart';
import 'package:pigemshubshop/core/domain/usecases/cart/delete_account_cart.dart';
import 'package:pigemshubshop/core/domain/usecases/cart/get_account_cart.dart';
import 'package:pigemshubshop/core/domain/usecases/cart/update_account_cart.dart';
import 'package:pigemshubshop/core/domain/usecases/checkout/pay.dart';
import 'package:pigemshubshop/core/domain/usecases/checkout/start_checkout.dart';
import 'package:pigemshubshop/core/domain/usecases/firebase_remote_config/get_app_update_remote.dart';
import 'package:pigemshubshop/core/domain/usecases/firebase_remote_config/get_home_screen_remote_dialog.dart';
import 'package:pigemshubshop/core/domain/usecases/payment_method/add_payment_method.dart';
import 'package:pigemshubshop/core/domain/usecases/payment_method/change_primary_payment_method.dart';
import 'package:pigemshubshop/core/domain/usecases/payment_method/delete_payment_method.dart';
import 'package:pigemshubshop/core/domain/usecases/payment_method/get_account_payment_method.dart';
import 'package:pigemshubshop/core/domain/usecases/payment_method/update_payment_method.dart';
import 'package:pigemshubshop/core/domain/usecases/product/add_product.dart';
import 'package:pigemshubshop/core/domain/usecases/product/delete_product.dart';
import 'package:pigemshubshop/core/domain/usecases/product/get_list_product.dart';
import 'package:pigemshubshop/core/domain/usecases/product/get_product.dart';
import 'package:pigemshubshop/core/domain/usecases/product/get_product_review.dart';
import 'package:pigemshubshop/core/domain/usecases/product/update_product.dart';
import 'package:pigemshubshop/core/domain/usecases/transaction/accept_transaction.dart';
import 'package:pigemshubshop/core/domain/usecases/transaction/add_review.dart';
import 'package:pigemshubshop/core/domain/usecases/transaction/change_transaction_status.dart';
import 'package:pigemshubshop/core/domain/usecases/transaction/get_account_transaction.dart';
import 'package:pigemshubshop/core/domain/usecases/transaction/get_all_transaction.dart';
import 'package:pigemshubshop/core/domain/usecases/transaction/get_transaction.dart';
import 'package:pigemshubshop/core/domain/usecases/wishlist/add_account_wishlist.dart';
import 'package:pigemshubshop/core/domain/usecases/wishlist/delete_account_wishlist.dart';
import 'package:pigemshubshop/core/domain/usecases/wishlist/get_account_wishlist.dart';
import 'package:pigemshubshop/core/repositories/account_repository_impl.dart';
import 'package:pigemshubshop/core/repositories/address_repository_impl.dart';
import 'package:pigemshubshop/core/repositories/auth_repository_impl.dart';
import 'package:pigemshubshop/core/repositories/cart_repository_impl.dart';
import 'package:pigemshubshop/core/repositories/checkout_repository_impl.dart';
import 'package:pigemshubshop/core/repositories/payment_method_repository_impl.dart';
import 'package:pigemshubshop/core/repositories/pi_analytics_service_impl.dart';
import 'package:pigemshubshop/core/repositories/product_repository_impl.dart';
import 'package:pigemshubshop/core/repositories/transaction_repository_impl.dart';
import 'package:pigemshubshop/core/repositories/wishlist_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pigemshubshop/utils/push_notifications.dart';
import 'package:provider/provider.dart';
import '../core/domain/usecases/firebase_remote_config/init_firebase_remote_config.dart';
import '../core/repositories/remote_widget_impl.dart';
import '../routes.dart';
import '../utils/notification_services.dart';
import 'common/pi_debug_print.dart';
import 'constants/pi_keys.dart';
import 'pages/auth/login/login_page.dart';

class PiGemsApp extends StatefulWidget {
  const PiGemsApp({Key? key}) : super(key: key);

  @override
  State<PiGemsApp> createState() => _PiGemsAppState();
}

class _PiGemsAppState extends State<PiGemsApp> {
  // Collection Reference
  final CollectionReference _accountCollection =
      FirebaseFirestore.instance.collection(CollectionsName.kACCOUNT);
  final CollectionReference _productCollection =
      FirebaseFirestore.instance.collection(CollectionsName.kPRODUCT);
  final FirebaseRemoteConfig _firebaseRemoteConfig =
      FirebaseRemoteConfig.instance;
  final CollectionReference _transactionCollection =
      FirebaseFirestore.instance.collection(CollectionsName.kTRANSACTION);
  final FirebaseCrashlytics _instance = FirebaseCrashlytics.instance;

  final FirebaseAnalyticsObserver _observer =
      FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

  // Repository Impl
  late AuthRepositoryImpl _authRepositoryImpl;
  late AccountRepositoryImpl _accountRepositoryImpl;
  late ProductRepositoryImpl _productRepositoryImpl;
  late CartRepositoryImpl _cartRepositoryImpl;
  late WishlistRepositoryImpl _wishlistRepositoryImpl;
  late AddressRepositoryImpl _addressRepositoryImpl;
  late PaymentMethodRepositoryImpl _paymentMethodRepositoryImpl;
  late CheckoutRepositoryImpl _checkoutRepositoryImpl;
  late TransactionRepositoryImpl _transactionRepositoryImpl;
  late RemoteWidgetImpl _remoteWidgetImpl;
  late PiAnalyticsServiceImpl _analyticsServiceImpl;

  /// Notification Only
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    _authRepositoryImpl = AuthRepositoryImpl(
        auth: FirebaseAuth.instance, collectionReference: _accountCollection);
    _accountRepositoryImpl =
        AccountRepositoryImpl(collectionReference: _accountCollection);
    _productRepositoryImpl =
        ProductRepositoryImpl(collectionReference: _productCollection);
    _cartRepositoryImpl =
        CartRepositoryImpl(collectionReference: _accountCollection);
    _wishlistRepositoryImpl =
        WishlistRepositoryImpl(collectionReference: _accountCollection);
    _addressRepositoryImpl =
        AddressRepositoryImpl(collectionReference: _accountCollection);
    _paymentMethodRepositoryImpl =
        PaymentMethodRepositoryImpl(collectionReference: _accountCollection);
    _checkoutRepositoryImpl =
        CheckoutRepositoryImpl(collectionReference: _transactionCollection);
    _transactionRepositoryImpl =
        TransactionRepositoryImpl(collectionReference: _transactionCollection);
    _remoteWidgetImpl = RemoteWidgetImpl(_firebaseRemoteConfig);

    _analyticsServiceImpl = PiAnalyticsServiceImpl();

    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        log('device token');
        log(value);
      }
    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            loginAccount: LoginAccount(_authRepositoryImpl),
            registerAccount: RegisterAccount(_authRepositoryImpl),
            logoutAccount: LogoutAccount(_authRepositoryImpl),
          )..isLoggedIn(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseRemoteWidgetProvider(
            InitFirebaseRemoteConfig(_remoteWidgetImpl)..execute(),
            GetAppUpdateRemoteConfig(_remoteWidgetImpl),
            GetHomeScreenRemoteDialog(_remoteWidgetImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DarkModeProvider()..getDarkMode(),
        ),
        ChangeNotifierProvider(
          create: (_) => CrashlyticsProvider(_instance)..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            getListProduct: GetListProduct(_productRepositoryImpl),
            getProduct: GetProduct(_productRepositoryImpl),
            getProductReview: GetProductReview(_productRepositoryImpl),
            addProduct: AddProduct(_productRepositoryImpl),
            updateProduct: UpdateProduct(_productRepositoryImpl),
            deleteProduct: DeleteProduct(_productRepositoryImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(
            addAccountWishlist: AddAccountWishlist(_wishlistRepositoryImpl),
            getAccountWishlist: GetAccountWishlist(_wishlistRepositoryImpl),
            deleteAccountWishlist:
                DeleteAccountWishlist(_wishlistRepositoryImpl),
            getProduct: GetProduct(_productRepositoryImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AddressProvider(
            addAddress: AddAddress(_addressRepositoryImpl),
            getAccountAddress: GetAccountAddress(_addressRepositoryImpl),
            updateAddress: UpdateAddress(_addressRepositoryImpl),
            deleteAddress: DeleteAddress(_addressRepositoryImpl),
            changePrimaryAddress: ChangePrimaryAddress(_addressRepositoryImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PaymentMethodProvider(
            addPaymentMethod: AddPaymentMethod(_paymentMethodRepositoryImpl),
            getAccountPaymentMethod:
                GetAccountPaymentMethod(_paymentMethodRepositoryImpl),
            updatePaymentMethod:
                UpdatePaymentMethod(_paymentMethodRepositoryImpl),
            deletePaymentMethod:
                DeletePaymentMethod(_paymentMethodRepositoryImpl),
            changePrimaryPaymentMethod:
                ChangePrimaryPaymentMethod(_paymentMethodRepositoryImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CheckoutProvider(
            startCheckout: StartCheckout(_checkoutRepositoryImpl),
            pay: Pay(_checkoutRepositoryImpl),
            updateProduct: UpdateProduct(_productRepositoryImpl),
            deleteAccountCart: DeleteAccountCart(_cartRepositoryImpl),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(
            getAccountTransaction:
                GetAccountTransaction(_transactionRepositoryImpl),
            getTransaction: GetTransaction(_transactionRepositoryImpl),
            getAllTransaction: GetAllTransaction(_transactionRepositoryImpl),
            acceptTransaction: AcceptTransaction(_transactionRepositoryImpl),
            addReview: AddReview(_transactionRepositoryImpl),
            changeTransactionStatus:
                ChangeTransactionStatus(_transactionRepositoryImpl),
            getAccountProfile: GetAccountProfile(_accountRepositoryImpl),
          ),
        ),
      ],
      child: Consumer<DarkModeProvider>(
        builder: (context, darkMode, child) {
          return MaterialApp(
            title: FlavorConfig.instance.flavorValues.roleConfig.appName(),
            theme: FlavorConfig.instance.flavorValues.roleConfig.theme(),
            navigatorKey: PiKeys.navigatorKey,
            darkTheme:
                FlavorConfig.instance.flavorValues.roleConfig.darkTheme(),
            themeMode: darkMode.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routes: routes,
            navigatorObservers: [_observer],
            debugShowCheckedModeBanner: false,
            home: Consumer<AuthProvider>(
              child: const BottomNavigation(),
              builder: (context, auth, child) {
                if (auth.checkUser || darkMode.isLoading) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (auth.isUserLoggedIn) {
                  return child!;
                }

                return const LoginPage();
              },
            ),
          );
        },
      ),
    );
  }
}
