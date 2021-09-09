import 'package:bloc_demo/counter/bloc/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MyHomeCubitPage extends StatefulWidget {
  @override
  _MyHomeCubitPageState createState() => _MyHomeCubitPageState();
}

class _MyHomeCubitPageState extends State<MyHomeCubitPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          context.read<CounterCubit>().increment();
        }
      ),
      appBar: AppBar(
        title: Text('Bloc Counter Example'),
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text(
              '$state',
              style: TextStyle(fontSize: 50.0),
            );
          },
        ),
      ),
    );
  }
}