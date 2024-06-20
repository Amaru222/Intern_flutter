import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/cubit/another_cubit.dart';
import 'package:practice/cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CounterCubit(),
        child: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CounterCubit, int>(
          listener: (context, state) {
            if (state == 5) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Counter Cubit reached 5!')),
              );
            }
          },
        ),
        BlocListener<AnotherCubit, int>(
          listener: (context, state) {
            if (state == 10) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Another Cubit reached 10!')),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Multi Cubit Listener Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Counter:'),
              BlocBuilder<CounterCubit, int>(
                builder: (context, count) {
                  return Text(
                    '$count',
                  );
                },
              ),
              const Text('Another Cubit:'),
              BlocBuilder<AnotherCubit, int>(
                builder: (context, count) {
                  return Text(
                    '$count',
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().increment(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
