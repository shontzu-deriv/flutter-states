import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ResultPage.dart';
import 'counter_cubit.dart';
import 'input_cubit.dart';

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
      routes: {
        '/result': (context) => const ResultPage(),
      },
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
  late CounterCubit counterCubit;
  late InputCubit inputCubit;

  @override
  void didChangeDependencies() {
    counterCubit = BlocProvider.of<CounterCubit>(context);
    // inputCubit = BlocProvider.of<InputCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        BlocBuilder<InputCubit, int>(builder: (context, state) {
          return TextFormField(
            onChanged: (String value) => inputCubit.setInputVal(value),
          );
        }),
        BlocConsumer<CounterCubit, int>(
          bloc: counterCubit,
          listener: (context, state) {
            const negative = SnackBar(
              content: Text('negative 5'),
            );
            if (state == -5) {
              ScaffoldMessenger.of(context).showSnackBar(negative);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // TextField(
                  //   textAlign: TextAlign.center,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'Enter a number',
                  //   ),
                  //   keyboardType: TextInputType.number,
                  //   inputFormatters: <TextInputFormatter>[
                  //     FilteringTextInputFormatter.digitsOnly
                  //   ],
                  // ),
                  Text(
                    "Counter: "
                    '$state',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          counterCubit.decrementCounter();
                        },
                        child: const Text("Decrement"),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          counterCubit.resetCounter();
                        },
                        child: const Text("Reset"),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          counterCubit.incrementCounter();
                        },
                        child: const Text("Increment"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/result')},
                        child: const Text("x"),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            {Navigator.of(context).pushNamed('/result')},
                        child: const Text("÷"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        // BlocBuilder<InputCubit, int>(
        //     bloc: inputCubit,
        //     builder: (context, state) {
        //       return Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           ElevatedButton(
        //             onPressed: () =>
        //                 { Navigator.of(context).pushNamed('/result')},
        //             child: const Text("x"),
        //           ),
        //           const SizedBox(
        //             height: 10,
        //             width: 10,
        //           ),
        //           ElevatedButton(
        //             onPressed: () =>
        //                 {Navigator.of(context).pushNamed('/result')},
        //             child: const Text("÷"),
        //           ),
        //         ],
        //       );
        //     })
      ]),
    );
  }
}
