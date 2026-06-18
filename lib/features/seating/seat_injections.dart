
import 'package:cinema_app/core/di/service_locator.dart';
import 'package:cinema_app/features/seating/data/datasources/theater_remote_datasource.dart';
import 'package:cinema_app/features/seating/data/repositories/theater_repository_impl.dart';
import 'package:cinema_app/features/seating/domain/repositories/theater_repository.dart';
import 'package:cinema_app/features/seating/domain/usecases/get_seat_type_use_case.dart';
import 'package:cinema_app/features/seating/domain/usecases/get_theater_use_case.dart';
import 'package:cinema_app/features/seating/domain/usecases/watch_seat_use_case.dart';
import 'package:cinema_app/features/seating/presentation/bloc/theater_bloc.dart';

void injectTheaterDatasource(){
  serviceLocator.registerLazySingleton<TheaterRemoteDatasource>(
    () => TheaterRemoteDatasourceImpl(
      serviceLocator(),
    )
  );
}

void injectTheaterRepository(){
  serviceLocator.registerLazySingleton<TheaterRepository>(
    () => TheaterRepositoryImpl(datasource: serviceLocator<TheaterRemoteDatasource>())
  );
}

void injectTheaterUsecases(){
  serviceLocator.registerLazySingleton(
    () => GetTheaterUseCase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => GetSeatTypeUseCase(repository: serviceLocator())
  );
  serviceLocator.registerLazySingleton(
    () => WatchSeatUseCase(repository: serviceLocator())
  );
}

void injectTheaterBloc(){
  serviceLocator.registerLazySingleton(
    () => TheaterBloc(
      getTheaterUseCase: serviceLocator(),
      getSeatTypeUseCase: serviceLocator(),
      watchSeatUseCase: serviceLocator(),
    )
  );
}