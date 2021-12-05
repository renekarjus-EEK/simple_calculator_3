class CalcResults {      //a model for calculation results objects
  int id = 0;
  double addHistory = 0;
  double subtractHistory = 0;
  double multiplyHistory = 0;
  double divideHistory = 0;
  num powerHistory = 0;
  double firstNumberHistory = 0;
  double secondNumberHistory = 0;
  String time = '';

  CalcResults(this.id,this.addHistory,this.subtractHistory,this.multiplyHistory,this.divideHistory,this.powerHistory,this.firstNumberHistory,this.secondNumberHistory,this.time);

  CalcResults.fromJson(Map<String,dynamic> calcResultsMap){    //named constructor to create a CalcResult object from map
    id = calcResultsMap['id'] ?? 0;
    addHistory = calcResultsMap['addHistory'] ?? 0;
    subtractHistory = calcResultsMap['subtractHistory'] ?? 0;
    multiplyHistory = calcResultsMap['multiplyHistory'] ?? 0;
    divideHistory = calcResultsMap['divideHistory'] ?? 0;
    powerHistory = calcResultsMap['powerHistory'] ?? 0;
    firstNumberHistory = calcResultsMap['firstNumberHistory'] ?? 0;
    secondNumberHistory = calcResultsMap['secondNumberHistory'] ?? 0;
    time = calcResultsMap['time'] ?? '';
  }

  Map<String, dynamic> toJson(){    //transform CalcResults object to map
    return {
      'id':id,
      'addHistory':addHistory,
      'subtractHistory':subtractHistory,
      'multiplyHistory':multiplyHistory,
      'divideHistory':divideHistory,
      'powerHistory':powerHistory,
      'firstNumberHistory':firstNumberHistory,
      'secondNumberHistory':secondNumberHistory,
      'time':time,
    };
  }
}