

import 'package:cinema_app/core/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AppExceptionFactory {
  static AppException fromException(dynamic exception, StackTrace? stackTrace) {
    if (exception is FirebaseAuthException) {
      return FirebaseFactory.fromFirebase(exception, stackTrace);
    }
    
    if (exception is FirebaseException) {
      return FirebaseFactory.fromFirebase(exception, stackTrace);
    }

    switch (exception) {
      case FormatException():
        return ParseException(exception: exception, stackTrace: stackTrace);
      case OutOfMemoryError():
      case StackOverflowError():
        return SystemException(exception: exception, stackTrace: stackTrace);
      default:
        return UnknownException(exception: exception, stackTrace: stackTrace);
    }
  }
}

class FirebaseFactory {
  static AppException fromFirebase(FirebaseException e, StackTrace? s) {
    // Firebase uses string-based codes across Auth, Firestore, and Storage
    return switch (e.code) {
      // Authentication & Permissions
      'user-not-found' || 'wrong-password' || 'invalid-credential' => 
          UnauthorizedException(exception: e, stackTrace: s),
      'permission-denied' => 
          UnauthorizedException(exception: e, stackTrace: s),
      
      // Data Integrity
      'not-found' => 
          NotFoundException(exception: e, stackTrace: s),
      'already-exists' => 
          BadRequestException(exception: e, stackTrace: s, message: 'Resource already exists'),
      
      // Availability
      'unavailable' || 'deadline-exceeded' => 
          ServiceUnavailableException(exception: e, stackTrace: s),
      
      // Fallback
      _ => BadRequestException(exception: e, stackTrace: s, message: e.message ?? 'Firebase Error'),
    };
  }
}