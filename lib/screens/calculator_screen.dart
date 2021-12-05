import 'package:flutter/material.dart';
import 'package:simple_calculator_2/controllers/calc_results_sp.dart';
import 'package:simple_calculator_2/models/calc_results_history.dart';
import 'bottom_bar.dart';
import 'dart:math';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController firstNumberController = TextEditingController();
  final TextEditingController secondNumberController = TextEditingController();
  final CalcResultSp resultSp = CalcResultSp();           //we need an instance of CalcResultSp from calc_results_sp.dart that we use to write and read data from SP

  double resultAdd = 0; //variables for results of operations
  double resultSubtract = 0;
  double resultMultiply = 0;
  double resultDivide = 0;
  num resultPower = 0;
  double first = 0;
  double second = 0;

  //function for calculations, will not return anything, only does calculations
  void calculate() {
    double firstNumber = double.parse(firstNumberController.text);
    double secondNumber = double.parse(secondNumberController.text);
    setState(() {               //let flutter know that some object has changed
      FocusScope.of(context).unfocus();                       //get rid of onscreen keyboard if button is pressed
      resultAdd = firstNumber + secondNumber;
      resultSubtract = firstNumber - secondNumber;
      resultMultiply = firstNumber * secondNumber;
      resultDivide = firstNumber / secondNumber;
      resultPower = pow(firstNumber, secondNumber);
      first = firstNumber;
      second = secondNumber;
    });
  }

  //method to write data to SP
  Future saveResults() async {
    DateTime now = DateTime.now();
    String currentTime = '${now.day}.${now.month}.${now.year} ${now.hour}:${now.minute}:${now.second}';   //get current time with string interpolation
    int id = resultSp.getCounter() + 1;    //calls to getCounter method in calc_results_sp and adds 1
    CalcResults newResults = CalcResults(id, resultAdd, resultSubtract, resultMultiply, resultDivide, resultPower, first, second, currentTime);      //CalcResult is the model we use (calc_results_history.dart) to create object
    resultSp.writeResults(newResults).then((_){ //call writeResult method in calc_results_sp to write data to SP. After results are written to SP, call setCounter method to update counter
      resultSp.setCounter();
    });

  }

  //function to clear fields
  void clearFields (){
    firstNumberController.clear();
    secondNumberController.clear();
    setState(() {               //let flutter know that some object has changed
      FocusScope.of(context).unfocus();         //get rid of onscreen keyboard if button is pressed
      resultAdd = 0;
      resultSubtract = 0;
      resultMultiply = 0;
      resultDivide = 0;
      resultPower = 0;
    });
  }

  void calculateSave(){    //method to calculate and save when CALCULATE button is pressed
    calculate();
    saveResults();
  }

  @override
  void initState() {                //when we call writeResults method, we want to make sure that SP have been initialised
    resultSp.init();                //initialise SP calling resultSp.init()
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '1st number'
            ),
            controller: firstNumberController,
            keyboardType: TextInputType.number,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),),
          TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '2nd number'
            ),
            controller: secondNumberController,
            keyboardType: TextInputType.number,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),),


          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),),
          Text(                                                    //print calculation results
            firstNumberController.text +" + "+secondNumberController.text + " = " + resultAdd.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            firstNumberController.text +" - "+secondNumberController.text + " = " + resultSubtract.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            firstNumberController.text +" x "+secondNumberController.text + " = " + resultMultiply.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            firstNumberController.text +" : "+secondNumberController.text + " = " + resultDivide.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            firstNumberController.text +" ^ "+secondNumberController.text + " = " + resultPower.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),),

          ElevatedButton(
            onPressed: calculateSave,
            child: const Text('  CALCULATE   '),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),),
          ElevatedButton(
            onPressed: clearFields,
            child: const Text('CLEAR FIELDS'),
          ),
        ],
      ),

      bottomNavigationBar: BottomBar(), //widget to show bottom bar with buttons
    );
  }
}
