import 'package:calculator/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  var userQues = '';
  var userAns = '';
  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Colors.deepPurple.shade200,
              systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.deepPurple.shade100, ),
              elevation: 0,
            )
          ),
          backgroundColor: Colors.deepPurple.shade100,
          body: Column(
            children: [
              Expanded(child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 50),
                      Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          child: Text(userQues,style: const TextStyle(fontSize: 40,color: Colors.black54),)
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          child: Text(userAns,style: const TextStyle(fontSize: 60),)
                      ),
                    ],
                 ),
                )
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                      child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if(index == 0){
                        return MyButton(
                          buttonTapped: (){
                            setState(() {
                              userQues = '';
                              userAns = '0';
                            });
                          },
                          buttonText: buttons[index],
                          Color:Colors.green,
                          textColor: Colors.white,
                        );
                      }else if(index == 1){
                        return MyButton(
                            buttonTapped: (){
                              setState(() {
                                userQues = userQues.substring(0,userQues.length-1);
                              });
                            },
                            buttonText: buttons[index],
                            Color:Colors.orangeAccent,
                            textColor: Colors.white);
                      }else if(index == buttons.length-1){
                        return MyButton(
                            buttonTapped: (){
                              setState(() {
                                equalPressed();
                              });
                            },
                            buttonText: buttons[index],
                            Color: isOperator(buttons[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                            textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple);
                      } else{
                        return MyButton(
                         buttonTapped: (){
                          setState(() {
                           userQues+=buttons[index];
                           });
                          },
                        buttonText: buttons[index],
                        Color: isOperator(buttons[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                        textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                      );
                      }
                    },
                  ))),
            ],
          ),
        ));
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed(){

    String finalQues = userQues;
    Parser p = Parser();
    Expression exp = p.parse(finalQues);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAns = eval.toString();
  }
}
