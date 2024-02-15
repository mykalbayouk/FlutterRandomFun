import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinAppState extends ChangeNotifier {
  var coinImages = <Image>[]; // List of images
  void init() {
    for (int i = 1; i < 19; i++) {
      coinImages.add(Image.asset('assets/images/coin/coin-$i.png'));
    }
    coinImages.add(Image.asset('assets/images/coin/coin-1.png'));
  }
}

class CoinFlip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ImageRotater();
  }
}

class ImageRotater extends StatefulWidget {
  @override
  State<ImageRotater> createState() => _ImageRotaterState();
}

class _ImageRotaterState extends State<ImageRotater> {
  @override
  Widget build(BuildContext context) {
    var appState = context.read<CoinAppState>();
    appState.init();
    var coinImages = appState.coinImages;

    int randomNum = Random().nextInt(100);
    return Column(
      children: <Widget>[
        SizedBox(
          height: 500,
          width: 500,
          child: coinImages[18],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _flipCoin(coinImages, randomNum, context);
          },
          child: Text('Flip Coin'),
        ),
      ],
    );
  }

  void _flipCoin(var coinImages, int randomNum, BuildContext context) {
    int toFlip;
    if (randomNum > 50) {
      toFlip = 10;
    } else {
      toFlip = 20;
    }

    var stream = Stream.periodic(Duration(milliseconds: 50), (x) => x)
        .take(3 * 19 + toFlip)
        .listen((event) {
      setState(() {
        // set coin[0] to the next image in the list
        // but save coin[0] to the end so it loops back to itself
        coinImages[18] = coinImages[event % 19];

        // if last image shift everything left one
      });
    });
    stream.onDone(() {
      stream.cancel();

      Timer(Duration(milliseconds: 500), () {
        if (toFlip == 10) {
          _showResult('Tails', context);
        } else {
          _showResult('Heads', context);
        }
      });
    });

    // make a popup to show the result
  }
}

void _showResult(String result, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Result'),
        content: Text(result),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
