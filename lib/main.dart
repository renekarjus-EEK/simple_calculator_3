import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';
import 'screens/converter_screen.dart';
import 'screens/calchistory_screen.dart';

void main() {
  runApp(const SimpleCalculator());
}

class SimpleCalculator extends StatelessWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(         //overall theme for calculator
          brightness: Brightness.dark,
          textTheme: const TextTheme(
              bodyText1: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Open Sans',
                  fontSize: 25))),
      routes: {    //navigation routes for screens
        '/': (context) => CalculatorScreen(),
        '/calchistory': (context) => CalculatorHistory(),
        '/converter': (context) => ConverterScreen(),
      },
      initialRoute: '/',   //first screen to show
    );
  }
}
