
import 'package:cinema_app/core/auth/bloc/auth_bloc.dart';
import 'package:cinema_app/core/auth/repositories/auth_repository.dart';
import 'package:cinema_app/core/auth/usecases/google_sign_in_use_case.dart';
import 'package:cinema_app/core/auth/usecases/login_use_case.dart';
import 'package:cinema_app/core/auth/usecases/logout_use_case.dart';
import 'package:cinema_app/core/auth/usecases/restore_session_use_case.dart';
import 'package:cinema_app/core/auth/usecases/sign_up_use_case.dart';
import 'package:cinema_app/core/di/service_locator.dart';
import 'package:cinema_app/features/auth/data/auth_remote_data_source.dart';
import 'package:cinema_app/features/auth/repositories/auth_repository_impl.dart';

void injectAuthRemoteDataSources(){
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      auth: serviceLocator(), 
      firestore: serviceLocator()
    )
  );
}

void injectAuthRepositories(){
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dataSource: serviceLocator<AuthRemoteDataSource>())
  );
}

void injectAuthUseCases(){
  serviceLocator.registerLazySingleton(
    () => LoginUseCase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => LogoutUseCase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => GoogleSignInUseCase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => SignUpUseCase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => RestoreSessionUseCase(repository: serviceLocator())
  );
}

void injectAuthBlocs(){
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      loginUseCase: serviceLocator(), 
      logoutUseCase: serviceLocator(),
      googleSignInUseCase: serviceLocator(),
      signUpUseCase: serviceLocator(),
      restoreSessionUseCase: serviceLocator(),
    )
  );
}