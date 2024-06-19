import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/cubit/another_cubit.dart';
import 'package:practice/cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CounterCubit, int>(
          listener: (context, state) {
            if (state == 5) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Counter Cubit reached 5!')),
              );
            }
          },
        ),
        BlocListener<AnotherCubit, int>(
          listener: (context, state) {
            if (state == 10) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Another Cubit reached 10!')),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Multi Cubit Listener Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Counter:'),
              BlocBuilder<CounterCubit, int>(
                builder: (context, count) {
                  return Text('$count',
                      style: Theme.of(context).textTheme.headline4);
                },
              ),
              Text('Another Cubit:'),
              BlocBuilder<AnotherCubit, int>(
                builder: (context, count) {
                  return Text('$count',
                      style: Theme.of(context).textTheme.headline4);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().increment(),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
