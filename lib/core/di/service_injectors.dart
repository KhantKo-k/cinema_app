import 'package:cinema_app/core/auth/bloc/auth_bloc.dart';
import 'package:cinema_app/core/di/service_locator.dart';
import 'package:cinema_app/core/navigation/app_router.dart';
import 'package:cinema_app/core/navigation/locale_refresh_notifier.dart';
import 'package:cinema_app/core/services/firebase_client_provider.dart';
import 'package:cinema_app/features/auth/auth_injections.dart';
import 'package:cinema_app/features/seating/seat_injections.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initServiceLocator() async {
  // ── External ──────────────────────────────────────────────────────────────
  serviceLocator.registerLazySingleton(() => FirebaseClientProvider.auth);
  serviceLocator.registerLazySingleton(() => FirebaseClientProvider.firestore);

  final prefs = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(prefs);
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());

  _initDataSources();
  _initRepositories();
  _initUseCases();
  _initBlocs();
  _initServices();
  _initAppRouter();
}

void _initDataSources() {
  //injectEasyInjectionDatasources();

  injectAuthRemoteDataSources();
  injectTheaterDatasource();
}

void _initRepositories() {
  //injectEasyRepository();

  injectAuthRepositories();
  injectTheaterRepository();
}

void _initUseCases() {
  //injectEasyUseCase();
  injectAuthUseCases();
  injectTheaterUsecases();
}

void _initBlocs() {
  injectAuthBlocs();
  injectTheaterBloc();
}

void _initServices() {
 // injectEasyLoader();
}

void _initAppRouter() {
  serviceLocator.registerSingleton<LocaleRefreshNotifier>(
    LocaleRefreshNotifier(),
  );
  serviceLocator.registerLazySingleton<AppRouter>(
    () => AppRouter(
      serviceLocator.get<AuthBloc>(),
      serviceLocator.get<LocaleRefreshNotifier>(),
    ),
  );
}
