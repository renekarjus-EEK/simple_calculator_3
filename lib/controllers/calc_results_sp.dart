import 'package:shared_preferences/shared_preferences.dart';
import '../models/calc_results_history.dart';
import 'dart:convert';

class CalcResultSp { //purpose of this class is to serve as an interface to write to and read from SP
  static late SharedPreferences prefs;   //static as we want retrieve same instance of Shared Preferences each time

  Future init() async {         //asynchronous
    prefs = await SharedPreferences.getInstance();  //we need to call init method once and 'prefs' will keep the value of the SP instance
  }

  Future writeResults(CalcResults calcResults) async {    //async method to write data to SP (all writes to SP are async). CalcResults is the model from calc_results_history.dart
    //calcResult object is transformed into a map with toJson method and then into a string with a json.encode method, strings can be saved to SP.
    prefs.setString(calcResults.id.toString(), json.encode(calcResults.toJson()));
  }

  List<CalcResults> getResults(){    //synchronous method to read all inserted results from SP, returns a list of results
    List<CalcResults> results = [];     //create empty list results of type CalcResults
    Set<String> keys = prefs.getKeys();     //Retrieve all keys saved in SP. We use Set instead of List, because Set is unordered list while List is ordered. SP contains only unordered data.
    keys.forEach((String key) {         //using foreach let's get values to keys
      if (key != 'counter') {           //if key is 'counter' we do not want to add it to results
        CalcResults calcResults = CalcResults.fromJson(
            json.decode(prefs.getString(key) ?? ''));   //decode, because a string is saved in SP. If it is null, pass empty string
        results.add(calcResults); //add calcResults object to results list
      }
    });
    return results;   //return results list
  }

  Future setCounter() async {                       //async method to set a counter to increment each time a new calculation is created
    int counter = prefs.getInt('counter') ?? 0;     //retrieve current value of counter. If no value has been written to counter, set counter to 0
    counter++;
    await prefs.setInt('counter', counter);         //set new value of counter by writing the value to counter key (key : value)
  }

  int getCounter(){                                 //synchronous method for retrieving counter value at the key 'counter'
    return prefs.getInt('counter') ?? 0;

  }

}

