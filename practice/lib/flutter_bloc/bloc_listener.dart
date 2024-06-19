import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/cubit/counter_cubit.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cubit Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            BlocBuilder<CounterCubit, int>(
              builder: (context, count) {
                return Text('$count',
                    style: Theme.of(context).textTheme.headline4);
              },
            ),
            BlocListener<CounterCubit, int>(
              listener: (context, state) {
                if (state == 5) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Count reached 5!')),
                  );
                }
              },
              child: Container(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterCubit>().increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
