import 'package:flutter/material.dart';
import 'package:flutter_game/screens/game_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.doHyeonTextTheme(
          const TextTheme(
            displayLarge: TextStyle(
                fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            displayMedium: TextStyle(
                fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.w400),
            headlineMedium: TextStyle(
                fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            titleLarge: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
            titleMedium: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            titleSmall: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyLarge: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyMedium: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            labelLarge: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            bodySmall: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            labelSmall: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          ),
        ),
      ),
      home: const GameScreen(),
    );
  }
}
