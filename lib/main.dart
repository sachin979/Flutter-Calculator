import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var sum = "0";
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: Colors.grey[300]),
      darkTheme:
          ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.wb_sunny,
                ),
                onPressed: () {
                  setState(() {
                    dark == true ? dark = false : dark = true;
                  });
                })
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                width: double.infinity,
                child: Text(
                  sum,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _button('7'),
                    _button('8'),
                    _button('9'),
                    _button('/'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _button('4'),
                    _button('5'),
                    _button('6'),
                    _button('*'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _button('1'),
                    _button('2'),
                    _button('3'),
                    _button('-'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _button('.'),
                    _button('0'),
                    _button('=<'),
                    _button('+'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(child: _button('AC')),
                    Expanded(child: _button('=')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(var number) {
    return FlatButton(
        padding: EdgeInsets.all(24),
        child: Center(
            child: number == "=<"
                ? Icon(
                    Icons.backspace,
                  )
                : Text(
                    number,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
                  )),
        onPressed: () {
          strcon(number);
        });
  }

  strcon(var char) {
    var check = int.tryParse(char);
    if (check == null) {
      if (char == "=<") {
        setState(() {
          sum = sum.substring(0, sum.length - 1);
        });
      } else if (char == "=") {
        ContextModel cm = ContextModel();
        Parser p = Parser();
        Expression exp = p.parse(sum.toString());
        setState(() {
          sum = exp.evaluate(EvaluationType.REAL, cm).toString();
        });
      } else if (char == "AC") {
        setState(() {
          sum = "0";
        });
      } else {
        setState(() {
          sum = sum + char.toString();
        });
      }
    } else {
      if (sum == "0") {
        setState(() {
          sum = char;
        });
      } else {
        setState(() {
          sum = sum + char.toString();
        });
      }
    }
  }
}
