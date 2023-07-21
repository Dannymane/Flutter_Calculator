import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '';

  // Buttons
  final List<String> buttons = [
    'C',
    '←',
    '^',
    '%',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  bool isOperator(String x) {
    if (x == '/' ||
        x == '*' ||
        x == '-' ||
        x == '+' ||
        x == '=' ||
        x == '%' ||
        x == '^') {
      return true;
    }
    return false;
  }

  
  void equalPressed() {
    if (isOperator(userInput[userInput.length - 1])) {
      userInput = userInput.substring(0, userInput.length - 1);
      equalPressed();
      return;
    }

    Parser p = Parser();
    Expression expression = p.parse(userInput);
    ContextModel cm = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(83, 43, 36, 1),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 220, 220, 220),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      answer,
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 220, 220, 220),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button
                  if (index == 0) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput = '';
                          answer = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: Color.fromARGB(255, 162, 162, 162),
                      textColor: Colors.black,
                    );
                  }
                  // Delete Button
                  else if (index == 1) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput =
                              userInput.substring(0, userInput.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Color.fromARGB(255, 162, 162, 162),
                      textColor: Colors.black,
                    );
                  }
                  // Num (^) Button
                  else if (index == 2) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          if (answer != '') {
                            userInput = answer + buttons[index];
                            answer = '';
                          } else {
                            userInput += buttons[index];
                          }
                        });
                      },
                      buttonText: "Num",
                      color: Color.fromARGB(255, 162, 162, 162),
                      textColor: Colors.black,
                    );
                  }
                  // % button
                  else if (index == 3) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          if (answer != '') {
                            userInput = answer + buttons[index];
                            answer = '';
                          } else {
                            userInput += buttons[index];
                          }
                        });
                      },
                      buttonText: buttons[index],
                      color: Color.fromARGB(255, 162, 162, 162),
                      textColor: Colors.black,
                    );
                  }
                  // = Button
                  else if (index == 18) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.orange[700],
                      textColor: Colors.white,
                    );
                  }
                  // numbers
                  else if (index == 4 ||
                      index == 5 ||
                      index == 6 ||
                      index == 8 ||
                      index == 9 ||
                      index == 10 ||
                      index == 12 ||
                      index == 13 ||
                      index == 14 ||
                      index == 16 ||
                      index == 17) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          if (answer != '') {
                            userInput = buttons[index];
                            answer = '';
                          } else {
                            userInput += buttons[index];
                          }
                        });
                      },
                      buttonText: buttons[index],
                      color: Color.fromARGB(255, 196, 196, 196),
                      textColor: Colors.black,
                    );
                  }
                  // other buttons
                  else {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          if (answer != '') {
                            userInput = answer + buttons[index];
                            answer = '';
                          } else {
                            userInput += buttons[index];
                          }
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.orange[700],
                      textColor: Colors.white,
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  const MyButton(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
