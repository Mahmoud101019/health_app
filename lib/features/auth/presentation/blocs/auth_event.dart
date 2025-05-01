abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String id;
  final String password;

  LoginEvent({required this.id, required this.password});
}

class ForgetPasswordEvent extends AuthEvent {
  final String email;

  ForgetPasswordEvent({required this.email});
}

class ResetPasswordEvent extends AuthEvent {
  final String newPassword;

  ResetPasswordEvent({required this.newPassword});
}