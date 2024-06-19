import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_cubit.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late CounterCubit _counterCubit;

  @override
  void initState() {
    super.initState();
    _counterCubit = CounterCubit();
  }

  @override
  void dispose() {
    _counterCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _counterCubit,
      child: Scaffold(
        appBar: AppBar(title: Text('Cubit Counter')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              BlocBuilder<CounterCubit, int>(
                builder: (context, count) {
                  return Text(
                    '$count',
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () => _counterCubit.increment(),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            SizedBox(height: 8),
            FloatingActionButton(
              onPressed: () => _counterCubit.decrement(),
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
