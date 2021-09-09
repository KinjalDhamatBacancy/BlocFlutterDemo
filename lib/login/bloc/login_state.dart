import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String errorUserName;
  final String errorPassword;
  final LoginStatus status;

  const LoginState(this.errorUserName, this.errorPassword, this.status);

  @override
  List<Object> get props => [errorUserName, errorPassword, status];

  LoginState copyWith({
    LoginStatus? status,
    String? username,
    String? password,
  }) {
    return LoginState(
      username ?? this.errorUserName,
      password ?? this.errorPassword,
      status ?? this.status,
    );
  }

  LoginState copyUserName({
    String? username,
  }) {
    return LoginState(
      username ?? this.errorUserName,
      this.errorPassword,
      LoginStatus(Status.initial),
    );
  }

  LoginState copyPassword({
    String? password,
  }) {
    return LoginState(
      errorUserName,
      password ?? this.errorPassword,
      LoginStatus(Status.initial),
    );
  }
}

enum Status { initial, loading, success, failed }

class LoginStatus {
  Status? status;
  String? value;

  LoginStatus.named(this.status, this.value);

  LoginStatus(this.status);
}
