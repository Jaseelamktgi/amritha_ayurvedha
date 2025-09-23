import 'dart:ui';
import 'package:amritha_ayurvedha/core/constants/font_strings.dart';
import 'package:amritha_ayurvedha/core/extensions/margin_extn.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_button.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_text.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_textfiled.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/providers/auth_provider.dart';
import 'home_screen.dart'; // Navigate after login

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(AssetsHelper.loginImg, fit: BoxFit.cover),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(color: Colors.black.withValues(alpha: 0)),
                  ),
                  Center(
                    child: Image.asset(
                      AssetsHelper.logo,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Login or register to book your appointments',
                          family: poppins600,
                          maxLines: 2,
                          size: 24,
                        ),
                        20.hBox,
                        AppText('Email', size: 16),
                        5.hBox,
                        AppTextField(
                          controller: usernameController,
                          hintText: 'Enter your email',
                          fillColor: Colors.grey.withValues(alpha: .2),
                          borderColor: Colors.black.withValues(alpha: .4),
                          borderWidth: 0.85,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                        ),
                        24.hBox,
                        AppText('Password', size: 16),
                        5.hBox,
                        AppTextField(
                          controller: passwordController,
                          hintText: 'Enter password',
                          fillColor: Colors.grey.withValues(alpha: .2),
                          borderColor: Colors.black.withValues(alpha: .4),
                          borderWidth: 0.85,
                          obscureText: true,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter password';
                            }
                            if (val.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        50.hBox,

                        Consumer<AuthProvider>(
                          builder: (context, auth, _) {
                            return AppButton(
                              btntext: auth.isLoading
                                  ? 'Logging in...'
                                  : 'Login',
                              bgColor: const Color(0xFF006837),
                              verticalPadding: 10,
                              color: Colors.white,
                              isLoading: auth.isLoading,
                              onTap: auth.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        final success = await auth.login(
                                          usernameController.text.trim(),
                                          passwordController.text.trim(),
                                        );
                                        if (success && context.mounted) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const HomeScreen(),
                                            ),
                                          );
                                        } else if (context.mounted) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                auth.errorMessage ??
                                                    'Login failed',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                            );
                          },
                        ),

                        80.hBox,

                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'By creating or logging into an account you are agreeing with our ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              height: 1.5,
                              fontFamily: poppins400,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  height: 1.5,
                                  fontFamily: poppins400,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Terms and Conditions clicked');
                                  },
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: poppins400,
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: poppins400,
                                  fontSize: 12,
                                  height: 1.5,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Privacy Policy clicked');
                                  },
                              ),
                              TextSpan(
                                text: '.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  height: 1.5,
                                  fontFamily: poppins400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        20.hBox,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
