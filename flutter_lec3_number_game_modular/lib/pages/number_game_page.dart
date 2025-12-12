import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lec3_number_game_modular/widgets/game_rules.dart';
import 'package:flutter_lec3_number_game_modular/widgets/game_title.dart';
import 'package:flutter_lec3_number_game_modular/widgets/number_button.dart';
import 'package:flutter_lec3_number_game_modular/widgets/play_prompt.dart';

class NumberGamePage extends StatefulWidget {
  const NumberGamePage({super.key});

  @override
  State<NumberGamePage> createState() => _NumberGamePageState();
}

class _NumberGamePageState extends State<NumberGamePage> {
  static const int _maxNumber = 1000;
  static const int _scoreIncrement = 5;

  final Random _random = Random();
  late GameState _gameState;
  int streak = 0;

  @override
  void initState() {
    super.initState();
    _gameState = GameState();
    _generateRandomNumbers();
  }

  void _generateRandomNumbers() {
    setState(() {
      _gameState = _gameState.copyWith(
        leftNumber: _random.nextInt(_maxNumber),
        rightNumber: _random.nextInt(_maxNumber),
      );

      // Regenerate if numbers are equal
      while (_gameState.leftNumber == _gameState.rightNumber) {
        _gameState = _gameState.copyWith(
          rightNumber: _random.nextInt(_maxNumber),
          isCorrect: false,
        );
      }
    });
  }

  void _onNumberPressed(int selectedNumber) {
    final isLeftSelected = selectedNumber == _gameState.leftNumber;
    final int largerNumber = max(_gameState.leftNumber, _gameState.rightNumber);
    final bool isCorrect = selectedNumber == largerNumber;

    setState(() {
      streak = (isCorrect ? streak + 1 : 0);
      _gameState = _gameState.copyWith(
        score:
            _gameState.score + (isCorrect ? _scoreIncrement : -_scoreIncrement),
        showFeedback: true,
        isCorrect: isCorrect,
        selectedSide: isLeftSelected ? ButtonSide.left : ButtonSide.right,
      );
    });

    // Clear feedback after delay and generate new numbers
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _gameState = _gameState.copyWith(showFeedback: false);
        });
        _generateRandomNumbers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Game'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/numbers_logo.png'),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.amber, width: 2),
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.amber.shade50, Colors.blue.shade50],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GameTitle(),
            const SizedBox(height: 16.0),
            const GameRules(),
            const SizedBox(height: 24.0),
            const PlayPrompt(),
            const SizedBox(height: 32.0),

            // Number Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberButton(
                  number: _gameState.leftNumber,
                  isSelected:
                      _gameState.selectedSide == ButtonSide.left &&
                      _gameState.showFeedback,
                  isCorrect: _gameState.isCorrect,
                  onPressed: () => _onNumberPressed(_gameState.leftNumber),
                ),
                NumberButton(
                  number: _gameState.rightNumber,
                  isSelected:
                      _gameState.selectedSide == ButtonSide.right &&
                      _gameState.showFeedback,
                  isCorrect: _gameState.isCorrect,
                  onPressed: () => _onNumberPressed(_gameState.rightNumber),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            // Score Display with Feedback
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Score: ${_gameState.score}',
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    if (_gameState.showFeedback) ...[
                      const SizedBox(width: 16.0),
                      Icon(
                        _gameState.isCorrect
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: _gameState.isCorrect ? Colors.green : Colors.red,
                        size: 32.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        _gameState.isCorrect
                            ? '+$_scoreIncrement'
                            : '-$_scoreIncrement',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: _gameState.isCorrect
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ],
                ),

                // Streak Counter
                if (streak > 1) ...[
                  const SizedBox(height: 8.0),
                  Text(
                    '${(streak)} in a row! 🔥',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),

            const Spacer(),

            // Reset Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    streak = 0;
                    _gameState = GameState();
                    _generateRandomNumbers();
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Game'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ButtonSide { left, right }

class GameState {
  final int leftNumber;
  final int rightNumber;
  final int score;
  final bool showFeedback;
  final bool isCorrect;
  final ButtonSide? selectedSide;

  const GameState({
    this.leftNumber = 0,
    this.rightNumber = 0,
    this.score = 0,
    this.showFeedback = false,
    this.isCorrect = false,
    this.selectedSide,
  });

  GameState copyWith({
    int? leftNumber,
    int? rightNumber,
    int? score,
    bool? showFeedback,
    bool? isCorrect,
    ButtonSide? selectedSide,
  }) {
    final newScore = score ?? this.score;

    return GameState(
      leftNumber: leftNumber ?? this.leftNumber,
      rightNumber: rightNumber ?? this.rightNumber,
      score: newScore,
      showFeedback: showFeedback ?? this.showFeedback,
      isCorrect: isCorrect ?? this.isCorrect,
      selectedSide: selectedSide ?? this.selectedSide,
    );
  }
}
