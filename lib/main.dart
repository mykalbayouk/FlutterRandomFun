import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_num_gen/Tools/coin.dart';
import 'package:random_num_gen/Tools/dice.dart';
import 'package:random_num_gen/Tools/random.dart';
import 'package:random_num_gen/Tools/wheel.dart';
import 'package:random_num_gen/layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RandomAppState()),
        ChangeNotifierProvider(create: (context) => WheelAppState()),
        ChangeNotifierProvider(create: (context) => DiceState()),
        ChangeNotifierProvider(create: (context) => CoinAppState()),
      ],
      builder: (context, child) { 
        return MaterialApp(
          title: 'RNG App',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red.shade100),
          ),
          home: MyHomePage(),
        );
      },
    );
  }
}




