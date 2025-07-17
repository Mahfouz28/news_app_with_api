part of 'login_cubit_cubit.dart';

@immutable
abstract class LoginCubitState {}

class LoginCubitInitial extends LoginCubitState {}

class LoginLoading extends LoginCubitState {}

class LoginSuccess extends LoginCubitState {}

class LoginError extends LoginCubitState {
  final String message;
  LoginError(this.message);
}
