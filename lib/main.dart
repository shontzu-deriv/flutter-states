import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Result.dart';
import 'counter_cubit.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.pink,
    ),
    home: BlocProvider(
        create: (context) => CounterCubit(), child: const HomePage()),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CounterCubit cubit;

  final integerSavedController = TextEditingController();

  void routingToMultiply(BuildContext context, int input, int state) {
    //Routing to pages from multiply_and_divide.dart
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return MultiplyFunction(
          input: input,
          state: state,
        );
      },
    ));
  }

  void routingToDivision(BuildContext context, int input, int state) {
    //Routing to pages from multiply_and_divide.dart
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return DivideFunction(
          input: input,
          state: state,
        );
      },
    ));
  }

  @override
  void didChangeDependencies() {
    cubit = BlocProvider.of<CounterCubit>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: BlocConsumer<CounterCubit, int>(
        bloc: cubit,
        listener: (context, state) {
          const snackBar = SnackBar(
            content: Text('State is reached'),
          );

          if (state == 5) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (BuildContext context, state) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: integerSavedController,
                  keyboardType: TextInputType.numberWithOptions(),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter value',
                  ),
                ),
                Text(
                  '$state',
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          cubit.decrement();
                        },
                        child: const Icon(Icons.remove)),
                    const SizedBox(height: 10, width: 10),
                    ElevatedButton(
                        onPressed: () {
                          cubit.reset();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                title: const Text('You have Reset')),
                          );
                        },
                        child: const Icon(Icons.refresh)),
                    const SizedBox(height: 10, width: 10),
                    ElevatedButton(
                        onPressed: () {
                          cubit.increment();
                        },
                        child: const Icon(Icons.add)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          int input = int.parse(integerSavedController.text);
                          routingToMultiply(context, input, state);
                        },
                        child: const Icon(Icons.close)),
                    const SizedBox(height: 10, width: 10),
                    ElevatedButton(
                        onPressed: () {
                          int input = int.parse(integerSavedController.text);
                          routingToDivision(context, input, state);
                        },
                        child: const Text('÷',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold))),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
