import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

List<FortuneItem> items = const [
  FortuneItem(child: Text("Hello")),
  FortuneItem(child: Text("Hi")),
  FortuneItem(child: Text("Poop")),
  FortuneItem(child: Text("Cheese")),
];

class WheelAppState extends ChangeNotifier {
  var items = <FortuneItem>[];

  void init() {
    for (int i = 0; i < 4; i++) {
      items.add(FortuneItem(child: Text("Item $i")));
    }
  }

  void addItem(String data) {
    items.add(FortuneItem(child: Text(data)));
    notifyListeners();
  }

  void removeItem(String data) {
    items.remove(FortuneItem(child: Text(data)));
    notifyListeners();
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                editItems();
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
                setState(
                  () => selected.add(
                    Fortune.randomInt(0, items.length),
                  ),
                );
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
}

void editItems() {
  print("poop");
}
