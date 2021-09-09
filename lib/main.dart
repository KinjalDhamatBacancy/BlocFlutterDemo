import 'package:bloc_demo/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/view/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            // Counter demo with bloc
            // BlocProvider<CounterBloc>(
            //   create: (context) => CounterBloc(),
            //   child: MyHomePage(),
            // )

            // Counter demo with cubit
            //     BlocProvider<CounterCubit>(
            //   create: (_) => CounterCubit(),
            //   child: MyHomeCubitPage(),
            // )

            // Login demo
            BlocProvider(
          create: (context) {
            return LoginBloc();
          },
          child: LoginPage(),
        ));
  }
}
