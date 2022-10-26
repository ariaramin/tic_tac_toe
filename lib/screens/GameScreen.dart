import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants/constants.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool isTurnO = true;
  List<String> gameState = ['', '', '', '', '', '', '', '', ''];
  List<List<int>> winPositions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];
  int counter = 0;
  int scoreX = 0;
  int scoreO = 0;
  bool hasGameFinished = false;
  String gameResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              secondaryColor,
              primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: _getBody(),
        ),
      ),
    );
  }

  Widget _getBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 34,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getScoreBoard(),
          hasGameFinished ? _getResultBoard() : _getGameBoard(),
        ],
      ),
    );
  }

  Widget _getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Card(
              elevation: 6,
              shape: !isTurnO
                  ? RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    )
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
              color: primaryColor,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 26,
                ),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("images/xplayer.png"),
                      width: 62,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "$scoreX",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Image(
                      image: AssetImage("images/x.png"),
                      width: 24,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            !isTurnO
                ? Text(
                    "Your Turn",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
        Column(
          children: [
            Card(
              elevation: 6,
              shape: isTurnO
                  ? RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    )
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
              color: primaryColor,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 26,
                ),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("images/oplayer.png"),
                      width: 62,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "$scoreO",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Image(
                      image: AssetImage("images/o.png"),
                      width: 24,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            isTurnO
                ? Text(
                    "Your Turn",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  Widget _getGameBoard() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: MediaQuery.of(context).size.width / 1.1,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: gameBoardColor,
      ),
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              _tapped(index);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: primaryColor,
              ),
              child: Center(
                child: gameState[index] != ""
                    ? Image(
                        image: AssetImage("images/${gameState[index]}.png"),
                        width: 54,
                        height: 54,
                      )
                    : Container(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getResultBoard() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: MediaQuery.of(context).size.width / 1.1,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: gameBoardColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: counter == 9 && gameResult == "Draw!"
                ? AssetImage("images/handshake.png")
                : isTurnO
                    ? AssetImage("images/xplayer.png")
                    : AssetImage("images/oplayer.png"),
            width: 132,
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            gameResult,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            height: 48,
            child: TextButton(
              onPressed: () {
                _restartGame(false);
              },
              style: TextButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.play_arrow_rounded,
                    size: 26,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Play Again",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 48,
            child: TextButton(
              onPressed: () {
                _restartGame(true);
              },
              style: TextButton.styleFrom(
                // backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Colors.white,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.restart_alt,
                    size: 22,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Restart The Game",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    if (hasGameFinished) {
      return;
    }

    setState(() {
      if (gameState[index] != "") {
        return;
      }

      if (isTurnO) {
        gameState[index] = "o";
      } else {
        gameState[index] = "x";
      }

      isTurnO = !isTurnO;
      counter += 1;

      _checkWinner();
    });
  }

  void _checkWinner() {
    for (var position in winPositions) {
      if (gameState[position[0]] == gameState[position[1]] &&
          gameState[position[1]] == gameState[position[2]] &&
          gameState[position[0]] != "") {
        _showResult(gameState[position[0]]);
        return;
      }
      if (counter == 9) {
        _showResult("");
      }
    }
  }

  void _showResult(String? winner) {
    setState(() {
      hasGameFinished = true;
      if (winner == "x") {
        scoreX += 1;
        gameResult = "X is winner!";
      } else if (winner == "o") {
        scoreO += 1;
        gameResult = "O is winner!";
      } else {
        gameResult = "Draw!";
      }
    });
  }

  void _restartGame(bool restartTheGame) {
    setState(() {
      gameState = ['', '', '', '', '', '', '', '', ''];
      hasGameFinished = false;
      counter = 0;
      if (restartTheGame) {
        scoreX = 0;
        scoreO = 0;
      }
    });
  }
}
