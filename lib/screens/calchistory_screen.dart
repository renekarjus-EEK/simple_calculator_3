import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import '../controllers/calc_results_sp.dart';
import '../models/calc_results_history.dart';


class CalculatorHistory extends StatefulWidget {
  const CalculatorHistory({Key? key}) : super(key: key);

  @override
  _CalculatorHistoryState createState() => _CalculatorHistoryState();
}

class _CalculatorHistoryState extends State<CalculatorHistory> {
  List<CalcResults> results = [];           //create empty list of type CalcResults for results
  final CalcResultSp resultSp = CalcResultSp();

  @override
  void initState() {                //when we call writeResults method, we want to make sure that SP have been initialised
    resultSp.init().then((value) {updateScreen();});                //initialise SP calling resultSp.init(). Initiate updateScreen when loading screen to show all results
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator history'),
      ),
      body: ListView(children: getContent()), //create a listview. With getContect method we build a ListTile view based on results retrieved from SP

      bottomNavigationBar: BottomBar(),   //widget to show bottom bar with buttons
    );
  }

  List<Widget> getContent(){
    List<Widget> tiles = [];    //empty list'tiles'
    results.forEach((calcResults) {     //for each result in results list we will add a new tile
      tiles.add(ListTile(
        title: Text('Timestamp: ${calcResults.time}'),   //timestamp
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,   //align results left
          children: <Widget>[
            Text('${calcResults.firstNumberHistory} + ${calcResults.secondNumberHistory} = ${calcResults.addHistory.toStringAsFixed(2)}'),
            Text('${calcResults.firstNumberHistory} - ${calcResults.secondNumberHistory} = ${calcResults.subtractHistory.toStringAsFixed(2)}'),
            Text('${calcResults.firstNumberHistory} x ${calcResults.secondNumberHistory} = ${calcResults.multiplyHistory.toStringAsFixed(2)}'),
            Text('${calcResults.firstNumberHistory} / ${calcResults.secondNumberHistory} = ${calcResults.divideHistory.toStringAsFixed(2)}'),
            Text('${calcResults.firstNumberHistory} ^ ${calcResults.secondNumberHistory} = ${calcResults.powerHistory.toStringAsFixed(2)}'),
          ],
        ),
      ));
    });
    return tiles;
  }

  void updateScreen(){   //method to show all results saved in SP
    results = resultSp.getResults();
    setState(() {

    });

  }

}
