


import 'package:cinema_app/core/error/exception_factory.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

abstract class Repository {
  Future<Either<Failure, T>> on<T>(Future<T> Function() fn) async {
    try{
      final result = await fn();
      return Right(result);
    } catch (e, s){
      final appException = AppExceptionFactory.fromException(e, s);
      if (kDebugMode) {
        debugPrint('Handled Exception: ${appException.toString()}');
      }
      return Left(Failure(exception: appException));
    }
  }

  Stream<Either<Failure, T>> onStream<T>(Stream<T> Function() fn) {
  try {
    return fn()
        .map<Either<Failure, T>>((data) => Right<Failure, T>(data))
        .handleError((e, s) {
      final appException = AppExceptionFactory.fromException(e, s);
      FlutterError.presentError(
        FlutterErrorDetails(
          exception: appException,
          stack: appException.stackTrace,
        ),
      );
    });
  } catch (e, s) {
    final appException = AppExceptionFactory.fromException(e, s);
    FlutterError.presentError(
      FlutterErrorDetails(
        exception: appException,
        stack: appException.stackTrace,
      ),
    );
    return Stream.value(Left(Failure(exception: appException)));
  }
}
}