import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:signals/signals.dart';

part 'login_page_controller.g.dart';

@Riverpod(keepAlive: true)
class LoginController extends _$LoginController {
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isSignupScreen = signal(false);
  void toggleSignupScreen() {
    isSignupScreen.value = !isSignupScreen.value;
  }

  @override
  bool build() {
    return false;
  }

  void login() {
    if (loginFormKey.currentState!.validate()) {
      // Perform login action
      print('Logged in with email: ${emailController.text}');
      state = true;
    }
  }

  void signup() {
    if (signupFormKey.currentState!.validate()) {
      // Perform signup action
      print('Signed up with email: ${emailController.text}');
      // Store user credentials locally
      // This is a dummy implementation
      print('User credentials stored locally');
      toggleSignupScreen();
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
