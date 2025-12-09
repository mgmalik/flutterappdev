import 'dart:math';

import 'package:flutter/material.dart';

enum ButtonType { leftButton, rightButton }

class NumberGamePage extends StatefulWidget {
  const NumberGamePage({super.key});

  @override
  State<NumberGamePage> createState() => _NumberGamePageState();
}

class _NumberGamePageState extends State<NumberGamePage> {
  final Random _random = Random();
  int _leftNumber = 0, _rightNumber = 0, _scores = 0;

  _NumberGamePageState() {
    _generateRandomNumbers();
  }

  void _generateRandomNumbers() {
    do {
      _leftNumber = _random.nextInt(1000);
      _rightNumber = _random.nextInt(1000);
    } while (_leftNumber == _rightNumber);
  }

  void _buttonClicked(ButtonType buttonType) {
    if (buttonType == ButtonType.leftButton) {
      if (_leftNumber > _rightNumber) {
        _scores += 5;
      } else {
        _scores -= 5;
      }
    } else {
      if (_leftNumber < _rightNumber) {
        _scores += 5;
      } else {
        _scores -= 5;
      }
    }
    setState(() {
      _generateRandomNumbers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Number Game App'),
        leading: Image.asset('assets/images/numbers_logo.png'),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amberAccent, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Text(
              'Number Game',
              style: TextStyle(
                color: Colors.brown,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Rules of Game:',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'If you pressed the larger number, then you will get 5 points. If you pressed the wrong button, then you will loose 5 points',
                style: TextStyle(color: Colors.blueGrey),
              ),
            ),
            Text(
              'Let us Play!!!',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 100.0,
                  child: FilledButton(
                    onPressed: () {
                      _buttonClicked(ButtonType.leftButton);
                    },
                    child: Text('$_leftNumber'),
                  ),
                ),
                SizedBox(
                  width: 100.0,
                  child: FilledButton(
                    onPressed: () {
                      _buttonClicked(ButtonType.rightButton);
                    },
                    child: Text('$_rightNumber'),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Scores: $_scores',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
