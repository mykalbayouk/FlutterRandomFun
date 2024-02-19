import 'package:flutter/material.dart';
import 'package:random_num_gen/Tools/coin.dart';
import 'package:random_num_gen/Tools/dice.dart';
import 'package:random_num_gen/Tools/random.dart';
import 'package:random_num_gen/Tools/wheel.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    Widget page;
    String title;
    switch (selectedIndex) {
      case 0:
        page = RandomNumber();
        title = "Generate a Random Number";
        break;
      case 1:
        page = WheelSpin();
        title = "Spin the Wheel";
        break;
      case 2:
        page = DiceRoll();
        title = "Roll the Dice";
        break;
      case 3:
        page = CoinFlip();
        title = "Flip the Coin";
        break;
      default:
        throw UnimplementedError('no page for index $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        drawer: Drawer(
          width: 115,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 123.0,
                child: DrawerHeader(                  
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Center(child: Text("Tools", 
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        fontSize: 20.0),
                        ),
                    ),
                ),
              ),
              ListTile(
                title: Icon(Icons.onetwothree, size: 65, color: Theme.of(context).colorScheme.primary,),
                selected: selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(0);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Icon(Icons.explore, size: 45, color: Theme.of(context).colorScheme.primary,),
                selected: selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(1);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 13,),
              ListTile(
                title: Icon(Icons.casino, size: 50, color: Theme.of(context).colorScheme.primary,),
                selected: selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(2);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 13,),
              ListTile(
                title: Icon(Icons.monetization_on, size: 45, color: Theme.of(context).colorScheme.primary,),
                selected: selectedIndex == 3,
                onTap: () {
                  // Update the state of the app
                  _onItemTapped(3);
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Center(child: page),
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}