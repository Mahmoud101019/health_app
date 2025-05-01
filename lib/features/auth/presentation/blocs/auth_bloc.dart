import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<ForgetPasswordEvent>(_onForgetPassword);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (event.id.isNotEmpty && event.password.isNotEmpty) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Invalid ID or password'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onForgetPassword(
    ForgetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (event.email.isNotEmpty) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Invalid email'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (event.newPassword.isNotEmpty) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Invalid password'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
