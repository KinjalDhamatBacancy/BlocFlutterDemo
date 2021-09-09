import 'package:bloc_demo/login/bloc/login_bloc.dart';
import 'package:bloc_demo/login/bloc/login_event.dart';
import 'package:bloc_demo/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: createMainView(),
    );
  }

  createMainView() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state.status.status == Status.failed ||
            state.status.status == Status.success) {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("${state.status.value}")));
          });
        }

        return Form(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'username',
                    errorText: state.errorUserName.isNotEmpty
                        ? state.errorUserName
                        : null,
                  ),
                  controller: _usernameController,
                  onChanged: (username) =>
                      context.read<LoginBloc>().add(UserNameChanged(username)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'password',
                    errorText: state.errorPassword.isNotEmpty
                        ? state.errorPassword
                        : null,
                  ),
                  controller: _passwordController,
                  obscureText: true,
                  onChanged: (password) =>
                      context.read<LoginBloc>().add(PasswordChanged(password)),
                ),
                TextButton(
                  onPressed: state.status.status != Status.loading
                      ? _onLoginButtonPressed
                      : null,
                  child: Text('Login'),
                ),
                Container(
                  child: state.status.status == Status.loading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    context.read<LoginBloc>().add(LoginButtonPressed(
          _usernameController.text,
          _passwordController.text,
        ));
  }
}
