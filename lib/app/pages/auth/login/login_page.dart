import 'package:pigemshubshop/app/constants/colors_value.dart';
import 'package:pigemshubshop/app/constants/pi_analytics_enum.dart';
import 'package:pigemshubshop/app/constants/validation_type.dart';
import 'package:pigemshubshop/app/providers/auth_provider.dart';
import 'package:pigemshubshop/app/widgets/error_banner.dart';
import 'package:pigemshubshop/config/flavor_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pigemshubshop/core/repositories/pi_analytics_service_impl.dart';
import 'package:provider/provider.dart';

import '../../../../routes.dart';
import 'widgets/sign_up_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Flavor
  FlavorConfig flavor = FlavorConfig.instance;

  // Form Key (For validation)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextEditingController & FocusNode
  final TextEditingController _txtEmailAddress = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();
  final FocusNode _fnEmailAddress = FocusNode();
  final FocusNode _fnPassword = FocusNode();

  // Obsecure Text
  bool _obsecureText = true;

  // Validation
  ValidationType validation = ValidationType.instance;

  @override
  void dispose() {
    _txtEmailAddress.dispose();
    _txtPassword.dispose();
    _fnEmailAddress.dispose();
    _fnPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo must svg, so we can changed the color based on primaryColor
                // SvgPicture.asset(
                //   'assets/images/logo.svg',
                //   semanticsLabel: 'Logo',
                //   color: ColorsValue.primaryColor(context),
                // ),
                Image.asset(
                  "assets/launcher_icons/icon-admin.png",
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 25),

                // Title
                Text(
                  'Log in to your Account',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Subtitle
                Text(
                  'Welcome back, please enter your details.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                // Form
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Input Email Address
                        TextFormField(
                          controller: _txtEmailAddress,
                          focusNode: _fnEmailAddress,
                          validator: validation.emailValidation,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value) =>
                              FocusScope.of(context).requestFocus(_fnPassword),
                          decoration: const InputDecoration(
                            hintText: 'Type your email address',
                            labelText: 'Email Address',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Input Password
                        TextFormField(
                          controller: _txtPassword,
                          focusNode: _fnPassword,
                          obscureText: _obsecureText,
                          validator: validation.passwordValidation,
                          onFieldSubmitted: (value) =>
                              FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_obsecureText
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded),
                              onPressed: () {
                                setState(() {
                                  _obsecureText = !_obsecureText;
                                });
                              },
                            ),
                            hintText: 'Type your password',
                            labelText: 'Password',
                          ),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            NavigateRoute.toForgotPassword(context: context);

                            PiAnalyticsServiceImpl().triggerLogEvent(
                              event: PiAnalyticsEnum.forgotPassword,
                              metaData: {"forgotEmailPressed": "true"},
                            );

                          },
                          child: Text(
                            'Forgot Password?',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Log In Button
                        Consumer<AuthProvider>(
                          builder: (context, value, child) {
                            if (value.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return ElevatedButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                // Check if the form valid
                                if (_formKey.currentState!.validate() &&
                                    !value.isLoading) {
                                  try {
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentMaterialBanner();

                                    PiAnalyticsServiceImpl()
                                        .login(PiAnalyticsEnum.emailLogin);

                                    await value
                                        .login(
                                      emailAddress: _txtEmailAddress.text,
                                      password: _txtPassword.text,
                                    )
                                        .then((e) {
                                      if (!value.isRoleValid) {
                                        _formKey.currentState!.reset();

                                        ScaffoldMessenger.of(context)
                                            .showMaterialBanner(
                                          errorBanner(
                                              context: context,
                                              msg:
                                                  'Your Account doesn\'t have the right permission'),
                                        );
                                      }
                                    });
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentMaterialBanner();
                                    ScaffoldMessenger.of(context)
                                        .showMaterialBanner(
                                      errorBanner(
                                          context: context, msg: e.toString()),
                                    );
                                  }
                                }
                              },
                              child: const Text('Login'),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Sign Up Text
                        const SignUpText(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
