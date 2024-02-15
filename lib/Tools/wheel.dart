import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';



class WheelAppState extends ChangeNotifier {
  List<FortuneItem> items = [
    FortuneItem(child: Text("Item 1")),
    FortuneItem(child: Text("Item 2")),
    FortuneItem(child: Text("Item 3")),
    FortuneItem(child: Text("Item 4")),
    FortuneItem(child: Text("Item 5")),
    FortuneItem(child: Text("poop")),
  ];


  get getItems => items;

  void addItem(String data) {
    items.add(FortuneItem(child: Text(data)));
    notifyListeners();
  }

  void removeItem(String data) {
    if (items.length == 2) {
      return;
    }
    removeTheOne(data);
    notifyListeners();
  }
  void removeTheOne(String data){
    for(int i = 0; i < items.length; i++){
      if(items[i].child.toString() == 'Text("$data")'){
        items.removeAt(i);
      }
    }
  }
  
}

class WheelSpin extends StatefulWidget {
  const WheelSpin({super.key});

  @override
  State<WheelSpin> createState() => _WheelSpin();
}

class _WheelSpin extends State<WheelSpin> {
  StreamController<int> selected = StreamController<int>();

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<WheelAppState>();
    var items = appState.getItems;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                editItems(context);
              },
             child: Text('Edit Items')
            ),
            Expanded(
              child: FortuneWheel(
                selected: selected.stream,
                animateFirst: false,
                duration: const Duration(seconds: 3),
                items: items,
                
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
              ),
              onPressed: () {
                var randoNum = Fortune.randomInt(0, items.length);
                setState(
                  () => selected.add(
                    randoNum,
                  ),
                );
                Timer(Duration(milliseconds: 3250), () {
                _showResult(context, items, randoNum);
                });
              },
              child: Text(
                "Spin the Wheel",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResult(BuildContext context, List<FortuneItem> items, int selected) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('The wheel has chosen:'),
          content: Text(
            items[selected].child.toString().substring(6, items[selected].child.toString().length - 2),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }

  void editItems(BuildContext context) {
    String _value = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var appState = context.watch<WheelAppState>();
        var items = appState.getItems;
        return AlertDialog(
          title: Text('Edit Items'),
          content: SizedBox(
            height: 300,
            child: Column(
              children: [
                Column(                
                  children: [
                    for(int i = 0; i < items.length; i++)
                      Text(
                        items[i].child.toString().substring(6, items[i].child.toString().length - 2),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.primary,                  
                        ),
                      ),
                  ],
                ),
                // i want to list the current items on the wheel, they are stored in widgets so i cant use dynamics
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'New Item',
                    ),
                    onChanged: (value) {
                      _value = value;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                      context.read<WheelAppState>().addItem(_value);
                  },
                  child: Text('Add Item'),
                ),
                ElevatedButton(
                  onPressed: () {
                      context.read<WheelAppState>().removeItem(_value.trim());
                  },
                  child: Text('Remove Item'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


