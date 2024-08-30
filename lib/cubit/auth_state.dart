part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// Signup State
final class SignupState extends AuthState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {}

final class SignupFailed extends SignupState {}

// Login State
final class LoginState extends AuthState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailed extends LoginState {
  final String error;

  LoginFailed(this.error);
}

final class Unauthenticated extends LoginState {}

// Rest Pssword state
final class resetPasswordStete extends AuthState {}

final class resetPasswordLoadingStete extends resetPasswordStete {}

final class resetPasswordSuccessStete extends resetPasswordStete {}

final class resetPasswordFailedStete extends resetPasswordStete {
  final String error;

  resetPasswordFailedStete(this.error);
}
