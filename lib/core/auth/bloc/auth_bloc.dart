import 'package:cinema_app/core/auth/bloc/auth_event.dart';
import 'package:cinema_app/core/auth/bloc/auth_state.dart';
import 'package:cinema_app/core/auth/usecases/google_sign_in_use_case.dart';
import 'package:cinema_app/core/auth/usecases/login_use_case.dart';
import 'package:cinema_app/core/auth/usecases/logout_use_case.dart';
import 'package:cinema_app/core/auth/usecases/restore_session_use_case.dart';
import 'package:cinema_app/core/auth/usecases/sign_up_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GoogleSignInUseCase googleSignInUseCase;
  final SignUpUseCase signUpUseCase;
  final RestoreSessionUseCase restoreSessionUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.googleSignInUseCase,
    required this.signUpUseCase,
    required this.restoreSessionUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginEvent);
    on<LogoutRequested>(_onLogoutEvent);
    on<GoogleSignInRequested>(_googleSignInEvent);
    on<SignUpRequested>(_signUpEvent);
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted( 
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());
    final user = await restoreSessionUseCase();
    user.fold(
      (failure){
        emit(Unauthenticated());
      },
      (userAuthModel){
        emit(Authenticated(userAuthModel: userAuthModel!));
      });
  }

  Future<void> _onLoginEvent(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());
    final result = await loginUseCase(event.email, event.password);
    result.fold(
      (failure) {
        emit(LoginFail(failure: failure));
      },
      (userAuthModel) {
        emit(Authenticated(userAuthModel: userAuthModel));
      },
    );
  }

  Future<void> _onLogoutEvent(LogoutRequested event, Emitter<AuthState> emit) async {
    await logoutUseCase();
    emit(Unauthenticated());
  }

  void _googleSignInEvent(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoading());
    final result = await googleSignInUseCase();
    result.fold(
      (failure) {
        emit(LoginFail(failure: failure));
      },
      (userAuthModel) {
        emit(Authenticated(userAuthModel: userAuthModel));
      },
    );
  }

  void _signUpEvent(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(SignUpLoading());
    final result = await signUpUseCase(
      event.name,
      event.email,
      event.password,
      event.phone,
    );
    result.fold(
      (failure) {
        emit(LoginFail(failure: failure));
      },
      (userAuthModel) {
        emit(SignUpSuccess(userAuthModel: userAuthModel));
      },
    );
  }
}
