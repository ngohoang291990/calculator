import 'dart:math';

import 'package:calculator/components/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    '0',
    '.',
    'ANS',
    '=',
  ];

  var questionText = '';
  var anserText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Text(questionText,
                          style: const TextStyle(fontSize: 20))),
                  Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        anserText,
                        style: const TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                  color: Colors.deepPurple[100],
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return MyButton(
                            onTap: () {
                              setState(() {
                                questionText = '';
                              });
                            },
                            color: Colors.green,
                            textColor: Colors.white,
                            buttonText: buttons[index]);
                      } else if (index == 1) {
                        return MyButton(
                            onTap: () {
                              setState(() {
                                if (questionText != '') {
                                  questionText = questionText.substring(
                                      0, questionText.length - 1);
                                }
                              });
                            },
                            color: Colors.red,
                            textColor: Colors.white,
                            buttonText: buttons[index]);
                      } else if (index == buttons.length - 1) {
                        return MyButton(
                            onTap: () {
                              setState(() {
                               equalOperator();
                              });
                            },
                            color: Colors.red,
                            textColor: Colors.white,
                            buttonText: buttons[index]);
                      } else {
                        return MyButton(
                            onTap: () {
                              setState(() {
                                questionText += buttons[index];
                              });
                            },
                            color: isOperator(buttons[index])
                                ? Colors.deepPurple
                                : Colors.deepPurple[50],
                            textColor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.deepPurple,
                            buttonText: buttons[index]);
                      }
                    },
                  ))),
        ],
      ),
    );
  }

  bool isOperator(String z) {
    if (z == '%' || z == '/' || z == '+' || z == '*' || z == '-' || z == '=') {
      return true;
    }
    return false;
  }

  void equalOperator() {
    String finalQuestion = questionText;
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    // cm.bindVariable(x, Number(2.0));
    // cm.bindVariable(y, Number(Math.PI));

    // Evaluate expression:
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    anserText = eval.toString();
  }
}
