import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../router/route_names.dart';
import '../../style/buttons.dart';
import '../../style/colors.dart';
import '../../style/extensions.dart';
import '../../style/texts.dart';
import '../products/products_home_page.dart';
import 'login_page_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late LoginController loginController;
  @override
  void initState() {
    loginController = ref.read(loginControllerProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Watch((context) {
        final isSignupScreen = loginController.isSignupScreen.value;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: isSignupScreen ? _buildSignupForm() : _buildLoginForm(),
        );
      }),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: loginController.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: AppTextStyles.h2,
            ),
            verticalSpace(32),
            TextFormField(
              controller: loginController.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              validator: loginController.validateEmail,
            ),
            verticalSpace(16),
            TextFormField(
              controller: loginController.passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              obscureText: true,
              validator: loginController.validatePassword,
            ),
            verticalSpace(20),
            AppPrimaryButton(
              margin: EdgeInsets.zero,
              onTap: () {
                loginController.login();
                context.replaceNamed(RouteNames.products);
              },
              label: 'Login',
            ),
            TextButton(
              onPressed: loginController.toggleSignupScreen,
              child: Text(
                "Don't have an account? Signup",
                style: AppTextStyles.p3.colored(AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return Form(
      key: loginController.signupFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Create Account',
            style: AppTextStyles.h2,
          ),
          verticalSpace(32),
          TextFormField(
            controller: loginController.emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            validator: loginController.validateEmail,
          ),
          verticalSpace(16),
          TextFormField(
            controller: loginController.passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            obscureText: true,
            validator: loginController.validatePassword,
          ),
          verticalSpace(16),
          TextFormField(
            controller: loginController.confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            obscureText: true,
            validator: loginController.validateConfirmPassword,
          ),
          const SizedBox(height: 20),
          AppPrimaryButton(
            margin: EdgeInsets.zero,
            onTap: loginController.signup,
            label: 'Signup',
          ),
          TextButton(
            onPressed: loginController.toggleSignupScreen,
            child: Text(
              'Already have an account? Login',
              style: AppTextStyles.p3.colored(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
