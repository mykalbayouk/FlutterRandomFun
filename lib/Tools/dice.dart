import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiceState with ChangeNotifier {
  var _diceNum = 1;
  var _numOfDice = 1;
  var _diceRolls = <int>[];
  var _totalRoll = 0;

  int get diceNum => _diceNum;
  int get numOfDice => _numOfDice;
  List<int> get diceRolls => _diceRolls;
  int get totalRoll => _totalRoll;

  DiceState() {
    _diceRolls.add(1);
  }


  int totalRollFind () {
    _totalRoll = 0;
    for (int i = 0; i < _numOfDice; i++) {
      _totalRoll += _diceRolls[i];
    }
    return _totalRoll;
  }

  void rollDice() {
    for(int i = 0; i < _numOfDice; i++) {
      _diceRolls[i] = Random().nextInt(6) + 1;
    }
    notifyListeners();
  }

  void addDice() {
    _diceRolls.add(1);
    _numOfDice++;
    notifyListeners();
  }

  void removeDice() {
    if (_numOfDice > 1) {
      _numOfDice--;
      notifyListeners();
    }
  }
}


class DiceRoll extends StatefulWidget {
  @override
  State<DiceRoll> createState() => _DiceRollState();
}

class Dice extends StatelessWidget {
  final int _diceNum;
  final int _numOfDice;

  Dice(this._diceNum, this._numOfDice);


  @override
  Widget build(BuildContext context) {
    double relativeSize = 1 / ( 1 + _numOfDice) * 350;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image(
        image: AssetImage('assets/images/dice/dice-$_diceNum.png'),
        width: (_numOfDice % 4 == 0) ? relativeSize * 2.5 : relativeSize,
        height: (_numOfDice % 4 == 0) ? relativeSize * 2.5 : relativeSize,
      ),
    );
  }
}

class _DiceRollState extends State<DiceRoll> {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<DiceState>();
    var diceRolls = appState.diceRolls;
    var numOfDice = appState._numOfDice;
    var totalRoll = appState.totalRollFind();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: appState.addDice, 
                child: Text('+ Dice')
                ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed:appState.removeDice, 
                child: Text('- Dice')
                ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: appState.rollDice,
            child: Text('Roll Dice'),
          ),
          SizedBox(height: 20),
          Wrap(
            children: [
              SizedBox(height: 20),
              for (int i = 0; i < numOfDice; i++)
                if (diceRolls[i] != 0)
                Dice(diceRolls[i], numOfDice), 
            ],
          ), 
          SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(totalRoll.toString(), 
              style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
