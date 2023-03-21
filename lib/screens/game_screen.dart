import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<List<int>> winningCases = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];
  static const String PLAYER1 = "O";
  static const String PLAYER2 = "X";

  late String currentPlayer;
  late bool gameEnd;
  late List<String> board;
  late Int recentPosition;

  // 게임을 시작합니다.(플레이어 및 보드 초기화)
  void startGame() {
    gameEnd = false;
    // 플레이어를 랜덤으로 결정합니다.
    currentPlayer = Random().nextBool() ? PLAYER1 : PLAYER2;
    board = ["", "", "", "", "", "", "", "", ""];
  }

  // 이긴 플레이어가 있는지 확인합니다.
  void checkWinner() {
    // 이길 수 있는 경우의 수를 반복문을 통해 확인하면서 모두 같은 플레이어의 포지션일 경우 게임에 승리하게 됩니다.
    for (List<int> winningCase in winningCases) {
      String position1 = board[winningCase[0]];
      String position2 = board[winningCase[1]];
      String position3 = board[winningCase[2]];

      // 비어있지 않은 경우
      if (position1.isNotEmpty) {
        // 모든 포지션이 같을 경우
        if (position1 == position2 && position1 == position3) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "게임이 종료되었습니다. ${position1 == "O" ? "PLAYER1" : "PLAYER2"}이 이겼습니다.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ));
          gameEnd = true;
          return;
        }
      }
    }
  }

  // 무승부인지 확인합니다.
  void checkDraw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (var player in board) {
      if (player.isEmpty) {
        draw = false;
      }
    }

    if (draw) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            "게임이 종료되었습니다. 무승부입니다.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );
      gameEnd = true;
    }
  }

  // 턴을 바꿉니다.
  void changeTurn() {
    if (currentPlayer == PLAYER1) {
      currentPlayer = PLAYER2;
    } else {
      currentPlayer = PLAYER1;
    }

    checkWinner();
    checkDraw();
  }

  // 보드를 클릭 했을 경우 발생하는 이벤트입니다.
  void onTabBoard(index) {
    // 보드에 이미 기호가 있거나 게임이 종료되었을 경우
    if (gameEnd || board[index].isNotEmpty) {
      return;
    }
    setState(() {
      board[index] = currentPlayer;
      changeTurn();
    });
  }

  void onPressReset() {
    setState(() {
      startGame();
    });
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange.shade200,
        title: Column(
          children: const [
            Text(
              "OX Game",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.deepOrange.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "PLAYER1 - 'O'",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    currentPlayer == PLAYER1
                        ? Icons.arrow_left
                        : Icons.arrow_right,
                    color: Colors.white,
                    size: 40,
                  ),
                  const Text(
                    "PLAYER2 - 'X'",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.deepOrange.shade200,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.height / 2,
                  margin: const EdgeInsets.all(8),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () => onTabBoard(index),
                          child: Container(
                            color:
                                gameEnd ? Colors.grey.shade300 : Colors.white,
                            margin: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                board[index],
                                style: TextStyle(
                                  fontSize: 44,
                                  color: board[index] == PLAYER1
                                      ? Colors.blue.shade400
                                      : Colors.red.shade400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.deepOrange.shade200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: onPressReset,
                      child: const Text(
                        "무르기",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: onPressReset,
                      child: const Text(
                        "다시하기",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
