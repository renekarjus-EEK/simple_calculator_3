import 'package:flutter/material.dart';
import 'bottom_bar.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final kmController = TextEditingController();
  final milesController = TextEditingController();

  double kmToMiles = 0;
  double milesToKm = 0;

  void convertKmToMiles(km) {
    setState(() {
      kmToMiles = km * 0.621371;
    });
  }

  void convertMilesToKm(miles) {
    setState(() {
      milesToKm = miles * 1.60934;
    });
  }

  void clearConverterFields() {
    //function to clear fields
    kmController.clear();
    milesController.clear();
    setState(() {
      //let flutter know that some object has changed
      FocusScope.of(context).unfocus();
      kmToMiles = 0;
      milesToKm = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KM <-> Miles converter'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          TextField(
            controller: kmController,
            onChanged: (text) {
              convertKmToMiles(double.parse(kmController.text));
            }, //convert
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter kilometers'),
            keyboardType: TextInputType.number, //keyboard with numbers
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          Text(
            //print conversion results
            kmController.text +
                " kilometers is " +
                kmToMiles.toStringAsFixed(2) +
                " miles ",
            //round to two decimals
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          TextField(
            controller: milesController,
            onChanged: (text) {
              convertMilesToKm(double.parse(milesController.text));
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter miles'),
            keyboardType: TextInputType.number,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),

          Text(                                                    //print conversion results
            milesController.text +" miles is " + milesToKm.toStringAsFixed(2)+" kilometers ",
            style: Theme.of(context).textTheme.bodyText1,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
          ),
          ElevatedButton(
            onPressed: clearConverterFields,
            child: const Text('Clear fields'),
          ),
        ],
      ),

      bottomNavigationBar: BottomBar(), //widget to show bottom bar with buttons
    );
  }
}
