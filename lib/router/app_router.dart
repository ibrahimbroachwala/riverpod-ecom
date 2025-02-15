import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entities/product.dart';
import '../pages/cart/cart_page.dart';
import '../pages/login/login_page.dart';
import '../pages/login/login_page_controller.dart';
import '../pages/product_details/product_details_page.dart';
import '../pages/products/products_home_page.dart';
import 'route_names.dart';
import 'route_paths.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@riverpod
class AppRouter extends _$AppRouter {
  @override
  RouterConfig build() {
    return _getAppRouter();
  }

  /// Use this for testing to change the initial
  /// location and quickly access some page
  @visibleForTesting
  String setInitialLocation(String location) => initialLocation = location;

  static String initialLocation = RoutePaths.login;

  RouterConfig _getAppRouter() {
    return GoRouter(
      initialLocation: initialLocation,
      debugLogDiagnostics: true,
      navigatorKey: navigatorKey,
      redirect: (context, state) async {
        //Get login status from authStatusProvider (Dummy)
        final isLoggedIn = ref.read(loginControllerProvider);
        final isLoggingIn = state.matchedLocation == RoutePaths.login;

        if (!isLoggedIn && !isLoggingIn) return RoutePaths.login;

        if (isLoggedIn && isLoggingIn) {
          return RoutePaths.products;
        }

        return null;
      },
      routes: [
        GoRoute(
            path: RoutePaths.login,
            name: RouteNames.login,
            builder: (context, state) {
              //LoginView
              return LoginPage();
            }),
        GoRoute(
            path: RoutePaths.products,
            name: RouteNames.products,  
            builder: (context, state) {
              //LoginView
              return ProductsHomePage();
            }),
        GoRoute(
            path: RoutePaths.productDetail,
            name: RouteNames.productDetail,
            builder: (context, state) {
              final product = state.extra! as Product;
              //LoginView
              return ProductDetailsPage(product: product);
            }),
        GoRoute(
            path: RoutePaths.cart,
            name: RouteNames.cart,
            builder: (context, state) {
              //LoginView
              return const CartPage();
            }),
      ],
    );
  }
}
