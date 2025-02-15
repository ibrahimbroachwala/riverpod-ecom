import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';

void main() async {
  await runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    //Init App-level dependencies (Firebase, Mobile Ads, PostHog, etc.)

    runApp(ProviderScope(
      child: App(),
    ));
  }, (error, stack) {
    //Catch errors with Crashlytics or Posthog
  });
}

class App extends ConsumerWidget {
  App({super.key});
  late RouterConfig? _router;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      _router = ref.watch(appRouterProvider);

      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: _router?.routerDelegate as RouterDelegate<Object>?,
        routeInformationParser:
            _router?.routeInformationParser as RouteInformationParser<Object>?,
        routeInformationProvider: _router?.routeInformationProvider,
      );
    });
  }
}
