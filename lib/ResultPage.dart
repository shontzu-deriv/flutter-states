import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("result page"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Input Value", style: TextStyle(fontSize: 30),),
          Text("Counter Value", style: TextStyle(fontSize: 30)),
          Text("Result Value", style: TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}
