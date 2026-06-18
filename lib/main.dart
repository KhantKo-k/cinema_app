// import 'package:cinema_app/app.dart';
// import 'package:cinema_app/core/di/service_injectors.dart';
// import 'package:cinema_app/core/di/service_locator.dart';
// import 'package:cinema_app/core/localization/presentation/fall_back_loader.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await EasyLocalization.ensureInitialized();
//   await initServiceLocator();
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [
//         Locale('en'),
//         Locale('my'),
//       ],
//       fallbackLocale: const Locale('en'),
//       path: 'assets/translations',
//       assetLoader: serviceLocator<RemoteFallbackLoader>(),
//       child: const ProviderScope(
//         child: App()),
//     )
//   );
// }

import 'package:cinema_app/app.dart';
import 'package:cinema_app/core/config/app_config.dart';
import 'package:cinema_app/core/di/service_injectors.dart';
import 'package:cinema_app/core/localization/presentation/providers/repository_providers.dart';
import 'package:cinema_app/core/localization/presentation/providers/translations_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.load();
  await Firebase.initializeApp();

  if (kReleaseMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  await EasyLocalization.ensureInitialized();
  await initServiceLocator();

  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final translationState = ref.watch(translationProvider);
          final loader = ref.watch(remoteFallbackLoaderProvider);
          return EasyLocalization(
            key: ValueKey(translationState.version),
            supportedLocales: const [Locale('en'), Locale('my')],
            fallbackLocale: const Locale('en'),
            startLocale: translationState.locale,
            saveLocale: true,
            useOnlyLangCode: true,
            path: 'assets/translations',
            assetLoader: loader,
            child: const App(),
          );
        },
      ),
    ),
  );
}
