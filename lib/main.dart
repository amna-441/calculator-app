import 'package:calculatorapp/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double firstnum = 0.0;
  double secondnum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputsize =  38.0;

  onButtonClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
       if(input.isNotEmpty){
       input = input.substring(0, input.length - 1);
       }
   
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userinput = input;
      userinput = input.replaceAll('×', '*');
      userinput = userinput.replaceAll('÷', '/');
      Parser p = Parser();
      Expression expression = p.parse(userinput);
      ContextModel cm = ContextModel();
      var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalvalue.toString();
   
         if (output.endsWith(".0")) {
             output = output.substring(0 , output.length - 2);
         }
         input = output;
         hideInput = true;
         outputsize = 50;
      }
      
    } else {
          hideInput = false;
         outputsize = 38;
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: outputsize,
                      color: Colors.white,
                ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(text: 'AC', tcolor: orangecolor),
              button(text: '<', tcolor: orangecolor),
              button(text: ''),
              button(text: '÷', tcolor: orangecolor),
            ],
          ),
          Row(
            children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: '×', tcolor: orangecolor),
            ],
          ),
          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-', tcolor: orangecolor),
            ],
          ),
          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+', tcolor: orangecolor),
            ],
          ),
          Row(
            children: [
              button(text: '%', tcolor: orangecolor),
              button(text: '0'),
              button(text: '.'),
              button(text: '=', buttonbgcolor: orangecolor),
            ],
          ),
        ],
      ),
    );
  } 
  Widget button({text, tcolor = Colors.white, buttonbgcolor = buttoncolor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: buttonbgcolor,
            padding: const EdgeInsets.all(22),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: tcolor,
            ),
          ),
        ),
      ),
    );
  }
}
