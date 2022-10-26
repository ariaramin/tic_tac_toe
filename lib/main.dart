import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/GameScreen.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Circular",
      ),
      home: GameScreen(),
    );
  }
}
