import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_demo/login/repository/user_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository? userRepository = UserRepository();

  LoginBloc() : super(LoginState("", "", LoginStatus(Status.initial)));

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield state.copyWith(status: LoginStatus(Status.loading));

      try {
        yield (await validateField(event));
      } catch (error) {
        yield state.copyWith(
            status: LoginStatus.named(Status.failed, error.toString()));
      }
    } else if (event is UserNameChanged) {
      if (event.username.isEmpty) {
        yield state.copyUserName(username: "Please enter user name");
      } else {
        yield state.copyUserName(username: "");
      }
    } else if (event is PasswordChanged) {
      if (event.password.isEmpty) {
        yield state.copyPassword(password: "Please enter password");
      } else {
        yield state.copyPassword(password: "");
      }
    }
  }

  Future<LoginState> validateField(LoginButtonPressed event) async {
    if (event.username.isEmpty) {
      return state.copyUserName(username: "Please enter user name");
    } else if (event.password.isEmpty) {
      return state.copyPassword(password: "Please enter password");
    } else {
      final token = await userRepository?.authenticate(
        username: event.username,
        password: event.password,
      );

      return state.copyWith(
          status: LoginStatus.named(Status.success, "Success"),
          username: "",
          password: "");
    }
  }
}
