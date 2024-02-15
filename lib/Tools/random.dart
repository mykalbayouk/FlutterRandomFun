import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RandomAppState with ChangeNotifier {

  var _min = -1;
  var _max = -1;
  var _randomNum = -1;

  var numbers = <int>[];

  void setMin(int value) {
    _min = value;
    notifyListeners();
  }

  void setMax(int value) {
    _max = value;
    notifyListeners();
  }

  void generateRandomNumber() {
    if (_min == -1 || _max == -1) {
      _randomNum = -1;
      return;
    } else if (_min > _max) {
      _randomNum = -1;
      return;
    } else if (_min == _max) {
      _randomNum = _min;
      return;
    }
    _randomNum = Random().nextInt(_max - _min + 1) + _min;
    numbers.add(_randomNum);
    notifyListeners();
  }
}

class RandomNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<RandomAppState>();
    var randomNum = appState._randomNum.toString();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: TextField(
                  onChanged: (String value) {
                    if (value == "") {
                      appState.setMin(0);
                    } else {
                      appState.setMin(int.parse(value));
                    }
                  },
                  decoration: InputDecoration(labelText: "Min"),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 15),
              SizedBox(
                width: 80,
                child: TextField(
                  onChanged: (String value) {
                    if (value == "") {
                      appState.setMax(10);
                    } else {
                      appState.setMax(int.parse(value));
                    }
                  },
                  decoration: InputDecoration(labelText: "Max"),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                appState.generateRandomNumber();
              },
              child: Text("Generate")),
          SizedBox(height: 25),
          if (randomNum != "-1")
            Text(
              randomNum,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}