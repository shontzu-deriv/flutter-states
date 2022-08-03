import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: BlocProvider(
          create: (context) => CounterCubit(),
          child: const MyHomePage(title: 'Bloc Practice')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CounterCubit cubit;

  @override
  void didChangeDependencies() {
    cubit = BlocProvider.of<CounterCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocConsumer<CounterCubit, int>(
        bloc: cubit,
        listener: (context, state) {
          const snackbar5 = SnackBar(
            content: Text('positive 5'),
          );
          const negative = SnackBar(
            content: Text('negative 5'),
          );
          if (state == 5) {
            ScaffoldMessenger.of(context).showSnackBar(snackbar5);
          }
          if (state == -5) {
            ScaffoldMessenger.of(context).showSnackBar(negative);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$state',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        cubit.decrementCounter();
                      },
                      child: const Text("Decrement"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.resetCounter();
                      },
                      child: const Text("Reset"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cubit.incrementCounter();
                      },
                      child: const Text("Increment"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
